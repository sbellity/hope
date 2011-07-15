require 'sinatra/base'
require 'erb'

module Hope
  module Server
    
    module Helpers

      # Getters...
      def statement
        statement_id = params[:statement_id] || params[:id]
        engine.statement(statement_id) or not_found
      end
    
      def engine
        engine_id = params[:engine_id] || params[:id]
        Hope::Engine.get(engine_id) or not_found
      end

      # Response...
      def respond_with d, code=200
        content_type :json
        status code
        d.to_json
      end

      def error_with message, code=400
        respond_with({ :error => message.to_s }, code)
      end

      # Request...
      def body
        @body ||= JSON.parse request.body.read rescue {}
      end

    end
  end
end

require 'hope/server/resources/engine'
require 'hope/server/resources/statement'
require 'hope/server/resources/source'
require 'hope/server/app'
