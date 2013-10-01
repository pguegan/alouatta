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
        }).jPlayer("play").jPlayer("mute")
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

    $("a.close").click ->
      player.jPlayer("clearMedia")
      container.hide()

    $("a.mute").click ->
      $(this).toggleClass("on")
      if $(this).hasClass("on")
        player.jPlayer("unmute")
      else
        player.jPlayer("mute")