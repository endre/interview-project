# frozen_string_literal: true

module Weather
  module Openweathermap
    class Client < ::Weather::Client
      API_URL_BASE = 'http://api.openweathermap.org/data/2.5/weather'

      option :params, reader: :private

      def call
        setup_connection
        fetch_data
        success
      rescue StandardError => e
        fail(e)
      end

      private

      def appid
        @_appid ||= Rails.application.secrets[:openweathermap_api_key]
      end
    end
  end
end