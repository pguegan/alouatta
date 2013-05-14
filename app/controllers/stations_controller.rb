class StationsController < ApplicationController
  
  def index
    @stations = Station.all
    @title = "MyJungly Radios"
  end

  def show
    @station = Station.new(params[:id])
    @song = @station.current_song
    @title = @station.name
  end

  def status
    @station = Station.new(params[:id])
    @song = @station.current_song
  end

end