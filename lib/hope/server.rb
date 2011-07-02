require 'sinatra/base'
require 'erb'

module Hope
  class Server < Sinatra::Base
    
    dir = File.dirname(File.expand_path(__FILE__))

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true
    
    def engine
      engine_id = params[:engine_id] || params[:id]
      Hope::Engine.get(engine_id) or raise Sinatra::NotFound
    end
    
    def statement
      engine.admin.getStatement(params[:statement_id]) or raise Sinatra::NotFound
    end
    
    get "/?" do
      redirect url(:overview)
    end

    get "/overview" do
      erb :overview
    end
    
    get "/engines/:engine_id" do
      content_type :json
      engine.to_json
    end
    
    post "/engines" do
      engine_id = params[:engine_id] || params[:id]
      e = Hope::Engine.get(engine_id) || Hope::Engine.new(engine_id)
      content_type :json
      e.to_json
    end
    
    post "/engines/:engine_id/statements" do
      st = engine.admin.createEPL(params[:statement], params[:statement_name])
      st.getName
    end
    
    post "/engines/:engine_id/statements/:statement_id/stop" do
      statement.stop
    end
    
    post "/engines/:engine_id/statements/:statement_id/start" do
      statement.start
    end
    
  end
end