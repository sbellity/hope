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
    
    java_import com.espertech.esper.client.EPServiceProviderManager
    
    attr_reader :provider, :uri
    
    def self.get uri=nil
      Hope.engines[uri]
    end
    
    def self.all
      EPServiceProviderManager.getProviderURIs.to_a
    end
    
    def initialize uri=nil
      @uri = uri || "default"
      Hope.register_engine(self)
      provider
      @sub = Hope.ctx.connect ZMQ::SUB, "ipc://hope", self if EM.reactor_running?
      @received = 0
      @registered_sources = {}
      @registered_types = {}
    end
    
    def on_readable(socket, messages)
      @received += 1
      src, msg = messages
      src_name = src.copy_out_string
      if self.register_source(src_name)
        evt = JSON.parse(msg.copy_out_string)
        # puts "OnReadable, sendding: #{evt.inspect}"
        self.sendEvent(evt["data"], evt["type"])
      else
        puts "Error: SOURCE #{src_name}, not registered !"
      end
    end    

    def register_source src_name
      return true if @registered_sources[src_name]
      src = Hope::Source.sources[src_name]
      return false if src.nil?
      src.class.event_types.each do |event_type|
        # puts "Adding eventType to engine #{self.uri}: #{event_type.name}:\n #{event_type.properties.inspect}"
        self.add_event_type(event_type)
      end
      @registered_sources[src] = src
    end
    
    def subscribe source_name
      @sub.subscribe source_name
      register_source(source_name)
    end

    def unsubscribe source_name
      @sub.unsubscribe source_name
    end

    # Provider API
    def provider
      if uri.nil?
        @provider ||= EPServiceProviderManager.getDefaultProvider
      else
        @provider ||= EPServiceProviderManager.getProvider(uri)
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
      statement_names.map { |n| Hope::Statement.new(admin.getStatement(n)) } 
    end
    
    def statement stmt_name
      s = admin.getStatement stmt_name
      Statement.new(s) unless s.nil?
    end
    
    def add_epl epl, name=nil
      name = nil if name.blank?
      Hope::Statement.new admin.createEPL(epl, name)
    end
    
    def add_pattern pattern, name=nil
      name = nil if name.blank?
      Hope::Statement.new admin.createPattern(pattern, name)
    end
    
    def add_event_type event_type
      return if @registered_types[event_type.name]
      @registered_types[event_type.name] = event_type.schema
      add_epl(event_type.schema)
    end
    
    def stop
      admin.stopAllStatements
    end
    
    def start
      admin.startAllStatements
    end
    
    # Runtime API
    def runtime
      provider.getEPRuntime
    end
    
    def sendEvent(e, type)
      runtime.sendEvent(e, type)
    end
    
    # Misc
    def serializable_hash
      {
        :id => uri,
        :received => @received,
        :statements => statements.map(&:serializable_hash)
      }
    end
    
    def to_json
      serializable_hash.to_json
    end
  end
  
end