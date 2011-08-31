module Hope
  
  
  module Source

    def self.sources
      @sources ||= {}
    end
  
    def self.register src
      self.sources[src.name] = src
    end
  
    def self.unregister src
      self.sources.delete src.name
    end
  
  end
  
end