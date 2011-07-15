module Hope
  module Server
    module Resources
      module Engine

        def self.registered app
          app.get "/engines/:engine_id" do
            content_type :json
            engine.to_json
          end

          app.get "/engines" do
            content_type :json
            Hope.engines.values.map { |e| e.serializable_hash }.to_json
          end

          app.put "/engines/:id" do
            engine_id = params[:id]
            respond_with(Hope::Engine.get(engine_id) || Hope::Engine.new(engine_id))
          end

          app.delete "/engines/:id" do
            e = Hope::Engine.get(params[:id])
            e.destroy unless e.nil?
          end

          app.post "/engines" do
            engine_id = params[:engine_id] || params[:id] || body["name"]
            if Hope::Engine.get(engine_id)
              error_with("Engine #{engine_id} already exists") 
            else
              respond_with Hope::Engine.new(engine_id)
            end
          end

          app.post "/engines/:id/stop" do
            engine.stop
            respond_with engine
          end

          app.post "/engines/:id/start" do
            engine.start
            respond_with engine
          end

          app.post "/engines/:engine_id/subscribe/:src_name" do
            engine.subscribe params[:src_name]
            respond_with engine
          end

          app.post "/engines/:engine_id/unsubscribe/:src_name" do
            engine.unsubscribe params[:src_name]
            respond_with engine
          end

        end
      end
    end
  end
end
