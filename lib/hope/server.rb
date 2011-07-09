require 'sinatra/base'
require 'erb'

module Hope
  class Server < Sinatra::Base
    
    dir = File.dirname(File.expand_path(__FILE__))

    configure do
      puts "Configure with reloader..."
      require 'sinatra/reloader'
      register Sinatra::Reloader
      also_reload "lib/**/*.rb"
    end

    set :views,  "#{dir}/server/views"
    set :public, "#{dir}/server/public"
    set :static, true
    
    def engine
      engine_id = params[:engine_id] || params[:id]
      Hope::Engine.get(engine_id) or not_found
    end
    
    def statement
      statement_id = params[:statement_id] || params[:id]
      engine.statement(statement_id) or not_found
    end
    
    def body
      @body ||= JSON.parse request.body.read
    end
    
    get "/?" do
      erb :app
    end
    
    get "/engines/:engine_id" do
      content_type :json
      engine.to_json
    end
        
    # Engines
    get "/engines" do
      content_type :json
      Hope.engines.values.map { |e| e.serializable_hash }.to_json
    end
    
    put "/engines/:id" do
      engine_id = params[:id]
      respond_with(Hope::Engine.get(engine_id) || Hope::Engine.new(engine_id))
    end
    
    delete "/engines/:id" do
      e = Hope::Engine.get(params[:id])
      e.destroy unless e.nil?
    end
    
    post "/engines" do
      engine_id = params[:engine_id] || params[:id] || body["name"]
      if Hope::Engine.get(engine_id)
        error_with("Engine #{engine_id} already exists") 
      else
        respond_with Hope::Engine.new(engine_id)
      end
    end
    
    
    post "/engines/:id/stop" do
      engine.stop
      respond_with engine
    end

    post "/engines/:id/start" do
      engine.start
      respond_with engine
    end
    
    post "/engines/:engine_id/subscribe/:src_name" do
      engine.subscribe params[:src_name]
      respond_with engine
    end

    post "/engines/:engine_id/unsubscribe/:src_name" do
      engine.unsubscribe params[:src_name]
      respond_with engine
    end
    
    # Statements
    
    get "/engines/:engine_id/statements" do
      respond_with engine.serializable_hash[:statements]
    end
    
    get "/engines/:engine_id/statements/:id" do
      respond_with statement
    end
    
    post "/engines/:engine_id/statements" do
      statement_id = body["id"] || body["statement_id"]
      begin
        respond_with(engine.add_epl(body["epl"], body["statement_id"]), 201)
      rescue => err
        error_with(err, 406)
      end
    end
    
    put "/engines/:engine_id/statements/:id" do
      error_with("You can't update an existing statement", 405)
    end
    
    delete "/engines/:engine_id/statements/:id" do
      statement.destroy
      status 205
    end
    
    post "/engines/:engine_id/statements/:statement_id/stop" do
      statement.stop unless statement.stopped?
      respond_with statement
    end
    
    post "/engines/:engine_id/statements/:statement_id/start" do
      statement.start
      respond_with statement
    end
    
    # Listeners
    
    get "/engines/:engine_id/statements/:statement_id/listeners" do
      statement.get_listeners.map { |l| { :name => l.name } }
    end
    
    post "/engines/:engine_id/statements/:statement_id/listeners" do
      statement.add_listener Hope::Listener::Base.new(body["name"])
    end
    
    # Sources
    
    get "/sources" do
      respond_with Hope::Source.sources.values.map(&:serializable_hash)
    end
    
    post "/sources" do
      source_type = body["type"]
      source_class = Hope::Source.const_get(source_type)
      src = source_class.new(body["name"], body["opts"])
    end
    
    private
    
    def respond_with d, code=200
      content_type :json
      status code
      d.to_json
    end
    
    def error_with message, code=400
      respond_with({ :error => message.to_s }, code)
    end
    
  end
end