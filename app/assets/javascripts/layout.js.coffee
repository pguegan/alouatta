jQuery ->
  popup = null
  $('a.open-radio-popup').click ->
    popup = window.open($(this).attr('href'), '', 'location=0, menubar=0, resizable=0, scrollbars=0, status=0, titlebar=0, toolbar=0, width=320, height=416, innerHeight=446', 'true')
    false
  $('a.close-radio-popup').click ->
    popup.close() if popup
    false

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
    timer.set({ time : 8000, autostart : true })

    $("a#switch").click ->
      position = $(this).attr("class")
      if (position == "on")
        $("#jplayer").jPlayer("clearMedia").jPlayer("stop")
        timer.pause()
        $(this).attr('class', "off")
        $(this).html("ON")
      else
        $("#jplayer").jPlayer("setMedia", {
          mp3: "http://stream.myjungly.fr/#{station}"
          oga: "http://stream.myjungly.fr/#{station}.ogg"
        }).jPlayer("play")
        timer.play(true)
        $(this).attr('class', "on")
        $(this).html("OFF")
      false

    $('#player .marquee').marquee()

    new Dragdealer('volume',
      x: 0.8
      callback: (x, y) ->
        $("#jplayer").jPlayer("volume", x)
    )
