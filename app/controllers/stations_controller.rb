class StationsController < ApplicationController

  caches_action :index, expires_in: 5.seconds
  caches_action :status, expires_in: 5.seconds

  rescue_from StationNotFound, with: :station_not_found

  def index
    @stations = Station.all
  end

  def status
    @station = Station.find(params[:id])
    @song = @station.current_song
  end

private

  def station_not_found
    render nothing: true, status: :not_found
  end

end