class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    loc = Location.new(permitted_params)
    if loc.save
      redirect_to root_path, notice: 'Location saved'
    else
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:location).permit(:name, :zip)
  end
end