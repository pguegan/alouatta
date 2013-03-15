class StationsController < ApplicationController
  
  def index
    @stations = Station.all
  end

  def show
    @station = Station.new(params[:id])
    @song = @station.current_song
  end

  def status
    @station = Station.new(params[:id])
    @song = @station.current_song
  end

end