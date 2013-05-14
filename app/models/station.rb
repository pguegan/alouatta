require 'open-uri'

class Station

  include ActiveAttr::Model

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.all
    @@stations ||= %w{cpor rider-radio adidas classics hip-hop hits lounge myjungly pop-rock soul-funk une-autre-radio}.map { |name| Station.new(name.upcase) }
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

private

  def default_cover_url
    case @name
      when "cpor" then "/assets/cpor/default.jpg"
      else "/assets/default.jpg"
    end
  end

  def cover_url(data)
    url = URI::encode("http://cdn.myjungly.fr/web/#{data[0]} - #{data[1]}.jpg")
    begin
      open(url).read
    rescue
      # 404 or something...
      url = default_cover_url
    end
    url
  end

end