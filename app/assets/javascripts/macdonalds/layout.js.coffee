jQuery ->
  
  player = $("#player")
  station = player.data('station')
  title = $("#title")
  marquee = $(".marquee_wrapper")

  etag = null
  loadData = ->
    $.ajax({
      url: "/stations/#{station}/status.json"
      headers: { "If-None-Match": etag }
      success: (data, status, xhr) ->
        if xhr.status == 200
          $("#song_separator").show()
          $('#song_artist').html(data.song.artist)
          $('#song_title').html(data.song.title)
          $(".marquee").marquee('destroy')
          $(".marquee").marquee(delayBeforeStart: 0)
          $('.rs-slider li.current img.song_cover').attr('src', data.song.cover)
          etag = xhr.getResponseHeader('ETag')
    })
  
  $("#song_separator").hide()
  $('#song_artist').html("Chargement...")

  player.jPlayer(
    ready: ->
      $(this).jPlayer("setMedia", {
        mp3: "http://mcdo.stream.instore.as57581.net:8000/#{station}"
        #oga: "http://mcdo.stream.instore.as57581.net:8000/#{station}.ogg"
      }).jPlayer("play")
    supplied: "mp3, oga"
    swfPath: "/assets"
  )

  $("#volume").click ->
    $(this).toggleClass("muted")
    if $(this).hasClass("muted")
      player.jPlayer("mute")
    else
      player.jPlayer("unmute")

  timer = $.timer( ->
    loadData()
  )
  timer.set({ time : 6000, autostart : true })

  $('.rs-slider').refineSlide(
    transition: 'cubeH'
    maxWidth: 334
    useThumbs: false
    useArrows: true
    startSlide: $(".rs-slider li.current").data("position")
    onChange: ->
      $("#song_separator").hide()
      $('#song_artist').html("Chargement...")
      nextId = this.slider.$nextSlide.data('id')
      currentId = this.slider.$currentSlide.data('id')
      this.slider.$currentSlide.removeClass("current")
      this.slider.$nextSlide.addClass("current")
      station = this.slider.$nextSlide.data('station')
      loadData()
      title.fadeTo(100, 0, ->
        title.attr("src", "/assets/macdonalds/#{nextId}/title.png")
      )
      player.jPlayer("stop")
      marquee.fadeTo(100, 0, ->
        marquee.removeClass(currentId).addClass(nextId)
      )
    afterChange: ->
      player.jPlayer("setMedia", {
        mp3: "http://mcdo.stream.instore.as57581.net:8000/#{station}"
        #oga: "http://mcdo.stream.instore.as57581.net:8000/#{station}.ogg"
      }).jPlayer("play").attr("data-station", station)
      title.fadeTo(500, 1)
      marquee.fadeTo(500, 1)
  )

  loadData()