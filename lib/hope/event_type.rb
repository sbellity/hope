require 'ostruct'

java_import 'com.espertech.esper.client.ConfigurationEventTypeLegacy'

module Hope
  class EventType < OpenStruct
    
    def self.schema
      schema_name = self.name.split("::").last
      "create schema #{schema_name} as (#{properties.map { |k,v| [k,v].join(" ") }.join(", ")})"
    end
    
    def self.register(engine)
      engine.add_epl(self.schema)
    end
    
    def get n
      puts "getting #{n} from #{self.name}"
      self.send n.to_sym
    end
  end
end