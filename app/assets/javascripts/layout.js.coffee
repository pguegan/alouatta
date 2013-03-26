jQuery ->
  if $('#player').length
    etag = null
    station = $('#player').data('station')

    $("#jplayer").jPlayer({
      ready: ->
        $(this).jPlayer("setMedia", {
          mp3: "http://stream.myjungly.fr/#{station}"
          oga: "http://stream.myjungly.fr/#{station}.ogg"
        }).jPlayer("play")
      supplied: "mp3, oga"
      swfPath: "/assets"
    })

    timer = $.timer( ->
      $.ajax({
        url: "/stations/#{station}/status.json"
        headers: { "If-None-Match": etag }
        success: (data, status, xhr) ->
          if xhr.status == 200
            $('#artist').html(data.song.artist)
            $('#title').html(data.song.title)
            $('#cover').attr('src', data.song.cover)
            etag = xhr.getResponseHeader('ETag')
      })
    )
    timer.set({ time : 5000, autostart : true })

    $("a#switch").click ->
      position = $(this).data("position")
      if (position == "on")
        $("#jplayer").jPlayer("stop")
        timer.pause()
        $(this).find('img').attr('src', "/assets/switch-off.png")
        $(this).data("position", "off")
      else
        $("#jplayer").jPlayer("play")
        timer.play(true)
        $(this).find('img').attr('src', "/assets/switch-on.png")
        $(this).data("position", "on")
      false

    $('marquee').marquee()

    new Dragdealer('volume',
      x: 0.8
      callback: (x, y) ->
        $("#jplayer").jPlayer("volume", x)
    )