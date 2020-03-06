module Weather
  module Fetchers
    class ByZip < ::DryService
      DEFAULT_OPTIONS = { units: :imperial }

      def call
        fetch
        success
      rescue StandardError => e
        error(e)
      end

      private

      # TODO: Do bulk update
      def fetch
        Location.where.not(zip: nil).find_each do |loc|
          response = Weather::Openweathermap::Client.call(params: DEFAULT_OPTIONS.merge({ zip: loc.zip }))
          loc.update!(weather_data: response.body) if response.success?
        end
      end
    end
  end
end