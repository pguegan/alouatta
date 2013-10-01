class StationsController < ApplicationController

  caches_action :status, expires_in: 5.seconds
  
  def index
    @stations = Station.all
    @title = "MyJungly Radios"
  end

  def show
    @station = Station.find(params[:id])
    @song = @station.current_song
    @title = @station.name
  end

  def status
    @station = Station.find(params[:id])
    @song = @station.current_song
  end

  def link
    @station = Station.find(params[:id])
  end

  def mini
    @station = Station.find(params[:id])
    @song = @station.current_song
    @title = @station.name
    render layout: nil
  end

end