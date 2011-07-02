module Hope
  
  def self.engines
    @engines ||= {}
  end
  
  def self.register_engine eng
    self.engines[eng.uri] = eng
  end
  
  def self.unregister_engine eng
    self.engines.delete eng.uri
  end
  
  class Engine
    
    attr_reader :provider, :uri
    
    def self.get uri=nil
      Hope.engines[uri]
    end
    
    def self.all
      com.espertech.esper.client.EPServiceProviderManager.getProviderURIs.to_a
    end
    
    def initialize uri=nil
      @uri = uri || "default"
      Hope.register_engine(self)
      provider
    end
    

    # Provider API
    def provider
      if uri.nil?
        @provider ||= com.espertech.esper.client.EPServiceProviderManager.getDefaultProvider
      else
        @provider ||= com.espertech.esper.client.EPServiceProviderManager.getProvider(uri)
      end
    end
    
    def destroy
      unless provider.destroyed?
        provider.destroy
        Hope.unregister_engine(self)
      end
    end

    def destroyed?
      provider.destroyed?
    end
    
    # Admin API
    def admin
      provider.getEPAdministrator
    end
    
    def statement_names
      admin.getStatementNames.to_a
    end
    
    def statements
      statement_names.inject({}) { |ss,n| ss.merge(n => admin.getStatement(n)) }
    end
    
    def add_epl epl, name=nil
      admin.createEPL epl, name
    end
    
    def add_pattern pattern, name=nil
      admin.createPattern pattern, name
    end
    
    # Runtime API
    def runtime
      provider.getEPRuntime
    end
    
    # Misc
    def serializable_hash
      {
        :id => uri,
        :statements => statement_names
      }
    end
    
    def to_json
      serializable_hash.to_json
    end
  end
  
end