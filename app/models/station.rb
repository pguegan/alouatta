require 'open-uri'
require 'net/http'

class Station

  include ActiveAttr::Model

  attr_reader :name

  def initialize(name)
    @name = name
  end

  class << self

    def stream
      Nokogiri::HTML(open('http://stream.myjungly.fr:8000/title.xsl'))
    end

    def all
      stations
    end

    def find(id, genre = nil)
      stations.find { |station| station.name.downcase == [id, genre].compact.join("_").downcase } || (raise StationNotFound, "Couldn't find station with id=#{id} and genre=#{genre}")
    end

  end

  def to_param
    name
  end

  def path
    if name =~ /RIFFX/
      "riffx"
    else
      "stations/#{to_param}"
    end
  end

  def current_song(stream = Station.stream)
    data = stream.xpath("//pre").first.content.scan(Regexp.new("#{stream_name}\\|\\|(.+)\\s-\\s(.+)")).first
    Song.new data[0], data[1], cover_url(data)
  rescue
    Song.new "My Jungly Music", "Radios sur mesure", default_cover_url
  end

private

  def stream_name
    name == "RIFFX_FAN" ? "RIFFX_KIDS" : name
  end

  def self.stations
    @@stations ||= %w{
      BASH
      CLASSICS
      HIP-HOP
      HITS
      LOUNGE
      LEGENDS
      MYJUNGLY
      POP-ROCK
      SOUL-FUNK
      UNE-AUTRE-RADIO
      RIFFX
      RIFFX_URBAN
      RIFFX_HITS
      RIFFX_FAN
      RIFFX_KIDS
      RIDER-RADIO
      ELECTRO
      ROOTS
      JAZZ
      FR
      SINEQUANONE
      URBAN
    }.map { |name| Station.new(name) }
  end

  def default_cover_url
    if name =~ /RIFFX/
      "/assets/riffx/default_cover.jpg"
    elsif name == "UNE-AUTRE-RADIO"
      "/assets/uar/default_cover.jpg"
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