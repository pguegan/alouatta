window.addEventListener("load", ->
  setTimeout( ->
    window.scrollTo(0, 0)
  , 10)
)

jQuery ->
  station = $('#player').data('station')

  new Dragdealer('volume',
    x: 0.8
    callback: (x, y) ->
      $("#jplayer").jPlayer("volume", x)
  )

  $("#jplayer").jPlayer({
    ready: ->
      $(this).jPlayer("setMedia", {
        mp3: "http://stream.myjungly.fr:8000/#{station}"
      }).jPlayer("play")
    supplied: "mp3"
  })

  timer = $.timer( ->
    $.get("/stations/#{station}/status.json", (data) ->
      $('#artist').html(data.song.artist)
      $('#title').html(data.song.title)
      $('#cover').attr('src', data.song.cover)
    )
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
      timer.play()
      $(this).find('img').attr('src', "/assets/switch-on.png")
      $(this).data("position", "on")
    false

  $('marquee').marquee()