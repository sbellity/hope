module Hope
  module Server
    module Resources
      module Source

        def self.registered app

          app.get "/sources" do
            # respond_with Hope::Source.sources.values.map(&:serializable_hash)
            # respond_with "bitly" => { "name" => "YO", "type" => "Twitter..." }
            respond_with "B" => "CD"
          end

          app.post "/sources" do
            source_type = body["type"]
            source_class = Hope::Source.const_get(source_type)
            src = source_class.new(body["name"], body["opts"])
          end

        end
      end
    end
  end
end
