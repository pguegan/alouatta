class CustomController < ApplicationController

  def show
    @station = Station.find(params[:id], params[:genre])
  	render params[:id], layout: nil
  end

end