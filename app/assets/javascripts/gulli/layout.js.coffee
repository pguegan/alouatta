jQuery ->

  etag = null
  loadData = ->
    $.ajax({
      url: "/stations/GULLI/status.json"
      headers: { "If-None-Match": etag }
      success: (data, status, xhr) ->
        if xhr.status == 200
          $('#song-artist').html(data.song.artist)
          $('#song-artist-marquee').marquee('destroy')
          if (data.song.artist).length > 20
            $('#song-artist-marquee').marquee(delayBeforeStart: 0, duplicated: true, gap: 80)
          $('#song-title').html(data.song.title)
          $('#song-title-marquee').marquee('destroy')
          if (data.song.title).length > 25
            $('#song-title-marquee').marquee(delayBeforeStart: 0, duplicated: true, gap: 80)
          $('#song-cover').css('background-image', "url('#{data.song.cover}')")
          etag = xhr.getResponseHeader('ETag')
    })

  player = $("#player")
  station = player.data('station')

  player.jPlayer(
    ready: ->
      $(this).jPlayer("setMedia", {
        mp3: "http://stream.myjungly.fr/GULLI"
        oga: "http://stream.myjungly.fr/GULLI.ogg"
      }).jPlayer("play")
    supplied: "mp3, oga"
    swfPath: "/assets"
    volume: 0.5
  ).bind($.jPlayer.event.play, (event) ->
    $('#loading').show()
  ).bind($.jPlayer.event.playing, (event) ->
    $('#loading').remove()
  )

  # $('.btn-power').click ->
  #   $(this).toggleClass('active')
  #   if $(this).hasClass('active')
  #     player.jPlayer("setMedia", {
  #       mp3: "http://stream.myjungly.fr/GULLI"
  #       oga: "http://stream.myjungly.fr/GULLI.ogg"
  #     }).jPlayer("play")
  #   else
  #     player.jPlayer("clearMedia").jPlayer("stop")

  timer = $.timer( ->
    loadData()
  )
  timer.set({ time : 6000, autostart : true }) 
  loadData()

  $('.dragdealer').css('top', $('.volume-bar').offset().top)
  new Dragdealer('volume',
    css3: false
    x: 0.5
    callback: (x, y) ->
      player.jPlayer("volume", x)
    animationCallback: (x, y) ->
      $("#volume-highlight").css("width", parseInt($('.handle').css('left')) + (x * parseInt($('.handle').css('width'))) + "px")
  )

  $(window).resize ->
    $('.dragdealer').css('top', $('.volume-bar').offset().top)
  #   $("#volume-highlight").css("width", parseInt($('.handle').css('left')) + 10 + "px") 

  # $('#btn-play').click ->
  #   player.jPlayer("play")
  #   $(this).fadeOut()

  # $(".btn-share-facebook").click ->
  #   width  = 575
  #   height = 400
  #   left   = ($(window).width()  - width)  / 2
  #   top    = ($(window).height() - height) / 2
  #   opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
  #   title  = "Web Radio Gulli"
  #   url    = 'http://www.gulli.fr'
  #   text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur radio Gulli. #{url}"
  #   window.open("https://www.facebook.com/sharer/sharer.php?s=100&p%5Burl%5Du=#{encodeURIComponent(url)}&p%5Btitle%5D=#{encodeURIComponent(title)}&p%5Bsummary%5D=#{encodeURIComponent(text)}&p%5Bimages%5D%5B0%5D=#{encodeURIComponent($('#song-cover').attr('src'))}", 'facebook-share-dialog', opts)
  #   false

  # $(".btn-share-twitter").click ->
  #   width  = 575
  #   height = 400
  #   left   = ($(window).width()  - width)  / 2
  #   top    = ($(window).height() - height) / 2
  #   opts   = 'status=1,width=' + width + ',height=' + height + ',top=' + top + ',left=' + left
  #   url    = 'http://www.gulli.fr'
  #   text   = "J'écoute #{$.trim($('#song-title').html())} de #{$.trim($('#song-artist').html())} sur radio Gulli."
  #   window.open("https://twitter.com/share?url=#{encodeURIComponent(url)}&text=#{encodeURIComponent(text)}", 'twitter', opts)
  #   false