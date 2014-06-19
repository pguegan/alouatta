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
          $('#song-cover').css('background-image', "url('#{data.song.cover.replace('\'', '%27')}')")
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
        mp3: "http://stream.myjungly.fr/GULLI"
        oga: "http://stream.myjungly.fr/GULLI.ogg"
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

  drag = new Dragdealer('volume',
    css3: false
    x: 0.5
    callback: (x, y) ->
      player.jPlayer("volume", x)
    animationCallback: (x, y) ->
      left = parseInt($('.handle').css('left'))
      width = parseInt($('.handle').css('width'))
      $("#volume-highlight").css("width", left + width / 2 + "px")
  )

  $(window).resize ->
    $('.dragdealer').css('top', $('.volume-bar').offset().top) if $('.volume-bar').length > 0
    
    left = parseInt($('.handle').css('left'))
    width = parseInt($('.handle').css('width'))
    $("#volume-highlight").css("width", left + width / 2 + "px")
    
    offset = $('.container').offset()
    if $(window).width() > 849
      $('.btn-power').css('top', offset.top + 245)
      $('.btn-power').css('left', offset.left + 265)
      $('.btn-share').css('top', offset.top + 305)
      $('.btn-share').css('left', offset.left + 672)
    else
      $('.btn-power').css('top', offset.top + 30)
      $('.btn-power').css('left', offset.left + 20)
      $('.btn-share').css('top', offset.top + 259)
      $('.btn-share').css('left', offset.left + 251)
  $(window).trigger('resize')

  $(".btn-share").click ->
    $(this).attr('href', "mailto:?subject=Gulli Radio&body=« #{$.trim($('#song-title').html())} » de #{$.trim($('#song-artist').html())} à écouter sur Gulli Radio, http://goo.gl/uriJMb.").attr('target', '_blank')