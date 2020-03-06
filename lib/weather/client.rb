# frozen_string_literal: true
require 'faraday'

module Weather
  class InvalidApiResponse < StandardError; end
  class Client < ::DryService
    USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'

    attr_reader :body

    protected

    attr_reader :connection, :response

    def uri
      @_uri ||= URI.parse(self.class::API_URL_BASE)
    end

    def api_server
      @_api_server ||= "#{uri.scheme}://#{uri.host}"
    end

    def setup_connection
      @connection = Faraday.new(url: api_server, headers: { user_agent: USER_AGENT}) do |c|
        c.adapter Faraday.default_adapter
      end
    end

    def fetch_data
      @response = connection.get("#{uri.path}?#{query}")
      validate_response
    end

    def validate_response
      if response.success?
        @body = JSON.parse(response.body)
      else
        raise InvalidApiResponse, response.to_hash
      end
    end

    def query
      @_query ||= begin
                    return {} unless params.present?
                    query = params.merge(appid: appid)
                    URI.encode_www_form(query)
                  end
    end
  end
end