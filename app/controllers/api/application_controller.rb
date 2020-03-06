module Api
  class ApplicationController < ActionController::API
    def render_response
      result = yield
      status = :ok
    rescue ActiveRecord::RecordNotFound => e
      result = e
      status = :bad_request
    ensure
      render json: result, status: status
    end
  end
end