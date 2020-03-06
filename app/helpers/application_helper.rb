module ApplicationHelper
  def location_exists
    @_location_exists ||= Location.exists?
  end
end
