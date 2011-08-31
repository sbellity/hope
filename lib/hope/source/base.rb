module Hope
  class Source::Base
  
    attr_reader :name, :options
    
    def self.event_types
      []
    end
    
    # Misc
    def serializable_hash
      {
        :id       => @name,
        :name     => @name,
        :type     => self.class.name,
        :options  => @options,
        :received => @received
      }
    end
  
    def to_json
      serializable_hash.to_json
    end
  
    def parse m
      JSON.parse m
    end
  
  end
end