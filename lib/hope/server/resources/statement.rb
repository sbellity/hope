module Hope
  module Server
    module Resources
      module Statement

        def self.registered app
          
          # Statements
          
          app.get "/engines/:engine_id/statements" do
            respond_with engine.serializable_hash[:statements]
          end

          app.get "/engines/:engine_id/statements/:id" do
            respond_with statement
          end

          app.post "/engines/:engine_id/statements" do
            statement_id = body["id"] || body["statement_id"]
            st = engine.add_epl(body["epl"], body["statement_id"])
            st.add_listener(Hope::Listener::Base.new(body["id"])) if body["listener"]
            begin
              respond_with(st, 201)
            rescue => err
              error_with(err, 406)
            end
          end

          app.put "/engines/:engine_id/statements/:id" do
            error_with("You can't update an existing statement", 405)
          end

          app.delete "/engines/:engine_id/statements/:id" do
            statement.destroy
            status 205
          end

          app.post "/engines/:engine_id/statements/:statement_id/stop" do
            statement.stop unless statement.stopped?
            respond_with statement
          end

          app.post "/engines/:engine_id/statements/:statement_id/start" do
            statement.start
            respond_with statement
          end
          
          # Listeners
          
          app.get "/engines/:engine_id/statements/:statement_id/listeners" do
            statement.get_listeners.map { |l| { :name => l.name } }
          end

          app.post "/engines/:engine_id/statements/:statement_id/listeners" do
            statement.add_listener Hope::Listener::Base.new(body["name"])
          end
          
        end
      end
    end
  end
end
