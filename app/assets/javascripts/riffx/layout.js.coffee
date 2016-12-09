jQuery ->

  player = $("#player")
  genre = player.data('genre')
  station = if genre == "" then "RIFFX" else "RIFFX_#{genre}"
  stream = if genre == "TEENS" then "http://stream.myjungly.fr/RIFFX_KIDS" else "http://stream.myjungly.fr/#{station}"
  etag = null

  loadData = ->
    $.ajax({
      url: "/stations/#{station}/status.json"
      headers: { "If-None-Match": etag }
      success: (data, status, xhr) ->
        if xhr.status == 200
          $('#song-artist').html(data.song.artist)
          $('#song-title').html(data.song.title)
          $('#song-cover').attr('src', data.song.cover)
          etag = xhr.getResponseHeader('ETag')
    })

  player.jPlayer(
    ready: ->
      $(this).jPlayer("setMedia", { mp3: stream }).jPlayer("play")
    supplied: "mp3"
    swfPath: "/assets"
    volume: 0.5
  ).bind($.jPlayer.event.play, (event) ->
    $('#loading').show()
  ).bind($.jPlayer.event.playing, (event) ->
    $('#loading').fadeOut()
  )

  $('.btn-power').click ->
    $(this).toggleClass('active')
    if $(this).hasClass('active')
      player.jPlayer("setMedia", { mp3: stream }).jPlayer("play")
    else
      player.jPlayer("clearMedia").jPlayer("stop")

  timer = $.timer( ->
    loadData()
  )
  timer.set({ time : 6000, autostart : true })

  new Dragdealer('volume',
    x: 0.5
    animationCallback: (x, y) ->
      player.jPlayer("volume", x)
      $("#volume-highlight").css("width", parseInt($('.handle').css('left')) + 10 + "px")
  )

  $(window).resize ->
    $("#volume-highlight").css("width", parseInt($('.handle').css('left')) + 10 + "px")

  $('#btn-play').click ->
    player.jPlayer("play")
    $(this).fadeOut()

  loadData()

  $(".btn-share-facebook").click ->
    width  = 575
    height = 400
    left   = ($(window).width()  - width)  / 2
    top    = ($(window).height() - height) / 2
    opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
    title  = "Web Radio RIFFX par Crédit Mutuel"
    url    = 'http://www.riffx.fr'
    text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur radio RIFFX. #{url}"
    window.open("https://www.facebook.com/sharer/sharer.php?s=100&p%5Burl%5Du=#{encodeURIComponent(url)}&p%5Btitle%5D=#{encodeURIComponent(title)}&p%5Bsummary%5D=#{encodeURIComponent(text)}&p%5Bimages%5D%5B0%5D=#{encodeURIComponent($('#song-cover').attr('src'))}", 'facebook-share-dialog', opts)
    false

  $(".btn-share-twitter").click ->
    width  = 575
    height = 400
    left   = ($(window).width()  - width)  / 2
    top    = ($(window).height() - height) / 2
    opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
    url    = 'http://www.riffx.fr'
    text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur radio RIFFX."
    window.open("https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(text)}", 'twitter', opts)
    false