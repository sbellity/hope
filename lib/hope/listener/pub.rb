java_import org.msgpack.MessagePack

module Hope 
  class Listener::Pub < Hope::Listener::Base
    
    attr_reader :received
    
    def self.pub socket
      @pubs ||= {}
      @pubs[socket] ||= Hope.ctx.bind ZMQ::PUB, socket
    end
    
    def initialize name, opts={}
      @name = name
      @socket = opts["socket"] || "ipc://hope-responses"
      @event_type = opts["event_type"]
      @received = { :success => 0, :errors => 0, :latest_error => "" }
      @pub = self.class.pub @socket
    end
    
    def update(newEvents, oldEvents)
      events = { :new_events => pack_events(newEvents), :old_events => pack_events(oldEvents), :name => @name }
      puts "Publishing new_events: #{events.inspect}"
      @pub.send_msg '', events.to_json
    end
    
    def pack_events events
      ret = []
      events.each do |event_bean|
        event = event_bean.getUnderlying
        event_properties = event_bean.getEventType.getPropertyNames.map &:to_s
        unless event.is_a?(Java::JavaUtil::HashMap) || event.is_a?(Hash)
          event = event_properties.inject({}) { |evd,k| evd.merge k => event_bean.getUnderlying.send(k.to_sym) }
        end
        event = event.to_hash
        ret << {
          :event_type       => event_bean.getEventType.getName,
          :event_properties => event_properties,
          :event            => event
        }
      end unless events.nil?
      ret
    end
        
  end
end