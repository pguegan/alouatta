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
    timer.set({ time : 6000, autostart : true })

    $("a#switch").click ->
      position = $(this).attr("class")
      if (position == "on")
        $("#jplayer").jPlayer("stop")
        timer.pause()
        $(this).attr('class', "off")
        $(this).html("ON")
      else
        $("#jplayer").jPlayer("play")
        timer.play(true)
        $(this).attr('class', "on")
        $(this).html("OFF")
      false

    $('#player[class!="cpor"][class!="neoplanete"] .marquee').marquee()

    new Dragdealer('volume',
      x: 0.8
      callback: (x, y) ->
        $("#jplayer").jPlayer("volume", x)
      animationCallback: (x, y) ->
        $("#player.neoplanete #volume-highlight").css("width", x * 175)
    )

    $("#player.neoplanete #overlay-show").click ->
      $(this).hide()
      $("#player.neoplanete #overlay").fadeIn()
    $("#player.neoplanete #overlay-hide").click ->
      $("#player.neoplanete #overlay").fadeOut()
      $("#player.neoplanete #overlay-show").show()