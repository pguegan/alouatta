jQuery ->

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
          $('.rs-slider li.current img.song_cover').attr('src', data.song.cover)
          etag = xhr.getResponseHeader('ETag')
    })
  
  player = $("#player")
  station = player.data('station')
  title = $("#title")

  $("#song_separator").hide()
  $('#song_artist').html("Chargement...")

  player.jPlayer(
    ready: ->
      $(this).jPlayer("setMedia", {
        mp3: "http://mcdo.stream.instore.as57581.net:8000/#{station}"
        oga: "http://mcdo.stream.instore.as57581.net:8000/#{station}.ogg"
      }).jPlayer("play")
    supplied: "mp3, oga"
    swfPath: "/assets"
  )

  timer = $.timer( ->
    loadData()
  )
  timer.set({ time : 6000, autostart : true })

  $("marquee").marquee("marquee")
	
  $('.rs-slider').refineSlide(
    transition: 'cubeH'
    maxWidth: 334
    useThumbs: false
    useArrows: true
    onChange: ->
      $("#song_separator").hide()
      $('#song_artist').html("Chargement...")
      id = this.slider.$nextSlide.data('id')
      this.slider.$currentSlide.removeClass("current")
      this.slider.$nextSlide.addClass("current")
      station = this.slider.$nextSlide.data('station')
      loadData()
      title.fadeTo(0, 0, ->
        title.attr("src", "/assets/macdonalds/#{id}/title.png").fadeTo(1500, 1)
      )
      player.jPlayer("stop")
    afterChange: ->
      player.jPlayer("setMedia", {
        mp3: "http://mcdo.stream.instore.as57581.net:8000/#{station}"
        oga: "http://mcdo.stream.instore.as57581.net:8000/#{station}.ogg"
      }).jPlayer("play").data("station", station)
  )

  loadData()