module Hope
  
  module Server
    class App < Sinatra::Base
      dir = File.dirname(File.expand_path(__FILE__))

      configure do
        puts "Configure with reloader..."
        require 'sinatra/reloader'
        register Sinatra::Reloader

        also_reload "lib/**/*.rb"
      end

      set :views,  "#{dir}/views"
      set :public, "#{dir}/public"
      set :static, true

      # Helpers
      helpers   Hope::Server::Helpers

      # Resources
      register  Hope::Server::Resources::Engine
      register  Hope::Server::Resources::Statement
      register  Hope::Server::Resources::Source

      get "/?" do
        erb :app
      end
      
      get "/bootstrap" do
        respond_with({
          :engines => Hope.engines.values.map { |e| e.serializable_hash },
          :sources => Hope::Source.sources.values.map(&:serializable_hash)
        })
      end
      
    end
  end
end