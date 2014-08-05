jQuery ->

  etag = null
  loadData = ->
    $.ajax({
      url: "/stations/UNE-AUTRE-RADIO/status.json"
      headers: { "If-None-Match": etag }
      success: (data, status, xhr) ->
        if xhr.status == 200
          $('#song-artist').html(data.song.artist)
          $('#song-title').html(data.song.title)
          $('#song-cover').css('background-image', "url('#{data.song.cover.replace('\'', '%27')}')")
          etag = xhr.getResponseHeader('ETag')
    })

  player = $("#player")
  station = player.data('station')

  player.jPlayer(
    ready: ->
      $(this).jPlayer("setMedia", {
        mp3: "http://stream.myjungly.fr/UNE-AUTRE-RADIO"
        #oga: "http://stream.myjungly.fr/UNE-AUTRE-RADIO.ogg"
      }).jPlayer("play")
    supplied: "mp3" #, oga"
    swfPath: "/assets"
    volume: 0.5
  ).bind($.jPlayer.event.play, (event) ->
    $('#overlay').show()
    $('#loading').show()
  ).bind($.jPlayer.event.playing, (event) ->
    $('#overlay').fadeOut()
    $('#loading').fadeOut()
  )

  $('.btn-power').click ->
    $(this).toggleClass('active')
    if $(this).hasClass('active')
      player.jPlayer("setMedia", {
        mp3: "http://stream.myjungly.fr/UNE-AUTRE-RADIO"
        #oga: "http://stream.myjungly.fr/UNE-AUTRE-RADIO.ogg"
      }).jPlayer("play")
    else
      player.jPlayer("clearMedia").jPlayer("stop")
      $('#overlay').show()
      $('#loading').hide()

  timer = $.timer( ->
   loadData()
  )
  timer.set({ time: 6000, autostart: true })
  loadData()

  $('#btn-play').click ->
    player.jPlayer("play")
    $(this).fadeOut()
    $(".btn-power").fadeIn()

  drag = new Dragdealer('volume',
    css3: false
    x: 0.5
    animationCallback: (x, y) ->
      player.jPlayer("volume", x)
      left = parseInt($('.handle').css('left'))
      width = parseInt($('.handle').css('width'))
      $("#volume-highlight").css("width", left + width / 2 + "px")
  )

  $(window).resize ->
    left = parseInt($('.handle').css('left'))
    width = parseInt($('.handle').css('width'))
    $("#volume-highlight").css("width", left + width / 2 + "px")
  $(window).trigger('resize')

  $(".btn-share-facebook").click ->
    width  = 575
    height = 400
    left   = ($(window).width()  - width)  / 2
    top    = ($(window).height() - height) / 2
    opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
    title  = "Une Autre Radio"
    url    = 'http://une-autre-radio.myjungly.fr'
    text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur Une Autre Radio. #{url}"
    window.open("https://www.facebook.com/sharer/sharer.php?s=100&p%5Burl%5Du=#{encodeURIComponent(url)}&p%5Btitle%5D=#{encodeURIComponent(title)}&p%5Bsummary%5D=#{encodeURIComponent(text)}&p%5Bimages%5D%5B0%5D=#{encodeURIComponent($('#song-cover').attr('src'))}", 'facebook-share-dialog', opts)
    false

  $(".btn-share-twitter").click ->
    width  = 575
    height = 400
    left   = ($(window).width()  - width)  / 2
    top    = ($(window).height() - height) / 2
    opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
    url    = 'http://une-autre-radio.myjungly.fr'
    text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur Une Autre Radio."
    window.open("https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(text)}", 'twitter', opts)
    false