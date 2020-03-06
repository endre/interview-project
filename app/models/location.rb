class Location < ApplicationRecord
  SERIALIZED_FIELDS = %w(temp temp_min temp_max)
  serialize :weather_data, JSON

  validates :name, :zip, presence: true

  def main_weather_data
    weather_data&.dig('main')
  end

  def current_temperature
    main_weather_data&.dig('temp')
  end

  def high_temperature
    main_weather_data&.dig('temp_max')
  end

  def low_temperature
    main_weather_data&.dig('temp_min')
  end

  def average_temperature
    return unless low_temperature && high_temperature
    ([low_temperature, high_temperature].sum / 2).round(2)
  end
end
