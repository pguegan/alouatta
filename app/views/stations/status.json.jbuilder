json.time l(Time.now)
json.song do |json|
  json.title @song.title
  json.artist @song.artist
  json.cover @song.cover
end