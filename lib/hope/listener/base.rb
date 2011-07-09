include_class 'com.espertech.esper.client.UpdateListener'

module Hope
  module Listener  
    class Base
      
      include UpdateListener
      
      attr_reader :name
      
      def initialize name, *args
        puts "Initialized new Listener: #{self.class.name}, with args: #{args.inspect}"
        @name = name
      end
      
      def update(newEvents, oldEvents)
        newEvents.each do |event|
          puts "[#{@name}] New event (#{event.getUnderlying.class}): #{event.getUnderlying.toString rescue event.getUnderlying.inspect}"
        end
      end
      
    end
  end
end
