class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    loc = Location.new(permitted_params)
    if loc.save
      Weather::Fetchers::ByZip.call(Location.where(id: loc.id))
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