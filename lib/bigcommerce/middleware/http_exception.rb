# frozen_string_literal: true

require 'bigcommerce/exception'

module Bigcommerce
  module Middleware
    class HttpException < Faraday::Middleware
      include Bigcommerce::HttpErrors

      def call(env)
        response = @app.call(env)
        response.on_complete do |completed_env|
          throw_http_exception! completed_env.status.to_i, completed_env
        end
        response
      end
    end
  end
end
