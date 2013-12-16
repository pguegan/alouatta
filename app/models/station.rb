require 'open-uri'
require 'net/http'

class Station

  include ActiveAttr::Model

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    stations
  end

  def self.index
    stations.reject { |station| station.name =~ /MCDO\d-|RIFFX/ }
  end

  def self.find(id)
    stations.find { |station| station.name.downcase == id.downcase } || (raise StationNotFound, "Couldn't find station with id=#{id}")
  end

  def to_param
    @name
  end

  def path
    if @name =~ /MCDO\d-/
      "macdonalds"
    elsif @name == "RIFFX"
      "riffx"
    else
      "stations/#{to_param}"
    end
  end

  def current_song
    if @name =~ /MCDO\d-/
      document = JSON.parse(open('http://mcdo.stream.instore.as57581.net/json.xsl').read)
      data = document["mounts"].select { |mount| mount["mount"] == "/#{@name}" }.first["title"].scan(Regexp.new("(.+)\\s-\\s(.+)")).first
    else
      document = Nokogiri::HTML(open('http://stream.myjungly.fr:8000/title.xsl'))
      data = document.xpath("//pre").first.content.scan(Regexp.new("#{@name}\\|\\|(.+)\\s-\\s(.+)")).first
    end
    Song.new data[0], data[1], cover_url(data)
  rescue
    Song.new "My Jungly Music", "Radios sur mesure", default_cover_url
  end

private

  def self.stations
    @@stations ||= %w{ADIDAS CLASSICS HIP-HOP HITS LOUNGE MYJUNGLY POP-ROCK SOUL-FUNK UNE-AUTRE-RADIO MCDO1- MCDO2- MCDO3- MCDO4- RIFFX RIDER-RADIO}.map { |name| Station.new(name) }
  end

  def default_cover_url
    if @name =~ /MCDO\d-/
      "/assets/macdonalds/default_cover.jpg"
    elsif @name == "RIFFX"
      "/assets/riffx/default_cover.jpg"
    else
      "/assets/default.jpg"
    end
  end

  def cover_url(data)
    http = Net::HTTP.new("cdn.myjungly.fr")
    response = http.request Net::HTTP::Head.new(URI::encode("/web/#{data[0]} - #{data[1]}.jpg"))
    if response.code == "200"
      URI::encode("http://cdn.myjungly.fr/web/#{data[0]} - #{data[1]}.jpg")
    else
      default_cover_url
    end
  end

end

class StationNotFound < StandardError
end