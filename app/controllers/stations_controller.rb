class StationsController < ApplicationController

  caches_action :index, expires_in: 5.seconds
  caches_action :status, expires_in: 5.seconds

  rescue_from StationNotFound, with: :station_not_found

  http_basic_authenticate_with name: "myjungly", password: "1707vTTv", only: :index unless Rails.env.development?

  def index
    respond_to do |format|
      format.html do
        @stations = Station.index
        @title = "MyJungly Radios"
      end
      format.json do
        @stations = Station.all
      end
    end
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

private

  def station_not_found
    render nothing: true, status: :not_found
  end

end