module Api
  module Frontend
    class WeatherController < Api::ApplicationController
      def index
        render_response do
          Location.all.to_json(only: %i[id name zip],
                               methods: %i[current_temperature low_temperature high_temperature average_temperature])
        end
      end

      def refresh
        Weather::Fetchers::ByZip.call
      end
    end
  end
end