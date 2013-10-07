jQuery ->
  container = $('#player')
  if container.length
    etag = null
    station = container.data('station')

    player = $("#jplayer")
    player.jPlayer({
      ready: ->
        $(this).jPlayer("setMedia", {
          mp3: "http://stream.myjungly.fr/#{station}"
          oga: "http://stream.myjungly.fr/#{station}.ogg"
        }).jPlayer("play")
        unless $("a.mute").hasClass("on")
          $(this).jPlayer("mute")
      supplied: "mp3, oga"
      swfPath: "/assets"
    })

    timer = $.timer( ->
      $.ajax({
        url: "/stations/#{station}/status.json"
        headers: { "If-None-Match": etag }
        success: (data, status, xhr) ->
          if xhr.status == 200
            $('#current-time').html(data.time)
            $('#current-artist').html(data.song.artist)
            $('#current-title').html(data.song.title)
            etag = xhr.getResponseHeader('ETag')
      })
    )
    timer.set({ time : 6000, autostart : true })

    $("a.maximize").click ->
      player.jPlayer("clearMedia")
      $('html').hide()
      window.open($(this).attr('href'), '', 'location=0, menubar=0, resizable=0, scrollbars=0, status=0, titlebar=0, toolbar=0, width=288, height=132, innerHeight=132', 'true')
      false

    $("a.mute").click ->
      $(this).toggleClass("on")
      if $(this).hasClass("on")
        player.jPlayer("unmute")
      else
        player.jPlayer("mute")