json.stations do
  stream = Station.stream
  json.array! @stations do |station|
    json.name station.name
    json.song do
      song = station.current_song(stream)
      json.title song.title
      json.artist song.artist
      json.cover song.cover
    end
  end
end