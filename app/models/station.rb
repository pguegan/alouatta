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
    Song.new(data[0], data[1], "http://cdn.myjungly.fr/web/#{data[0]} - #{data[1]}.jpg")
  rescue
    Song.new("My Jungly Music", "Radios sur mesure", "http://cdn.myjungly.fr/web/My%20Jungly%20Music%20-%20Radios%20sur%20mesure.jpg")
  end

end