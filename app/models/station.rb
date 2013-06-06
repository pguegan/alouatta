require 'open-uri'
require 'net/http'

class Station

  include ActiveAttr::Model

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    @@stations ||= %w{CPOR RIDER-RADIO NEOPLANETE ADIDAS CLASSICS HIP-HOP HITS LOUNGE MYJUNGLY POP-ROCK SOUL-FUNK UNE-AUTRE-RADIO}.map { |name| Station.new(name) }
  end

  def to_param
    @name
  end

  def current_song
    document = Nokogiri::HTML(open('http://94.23.143.166:8000/title.xsl'))
    data = document.xpath("//pre").first.content.scan(Regexp.new("#{@name}\\|\\|(.+)\\s-\\s(.+)")).first
    Song.new data[0], data[1], cover_url(data)
  rescue
    Song.new "My Jungly Music", "Radios sur mesure", default_cover_url
  end

  def facebook_url
    case @name
      when "NEOPLANETE" then "https://www.facebook.com/neoplanete"
    end
  end

  def twitter_url
    case @name
      when "NEOPLANETE" then "https://twitter.com/NEOPLANETE"
    end
  end

private

  def default_cover_url
    case @name
      when "CPOR" then "/assets/cpor/default.jpg"
      else "/assets/default.jpg"
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