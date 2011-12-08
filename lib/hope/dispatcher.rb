require 'active_support/concern'

module Hope
  
  module Dispatcher
    
    class Event
      attr_reader :attributes, :_type
      def initialize _type, attributes
        @_type = _type
        @attributes = attributes || {}
      end
      
      def method_missing m, *args
        if m.to_s =~ /\=$/ && args.length == 1
          @attributes[m.to_s.gsub(/\=$/, "")] = args.first
        else
          @attributes[m.to_s]
        end
      end
    end
    
    extend ActiveSupport::Concern
        
    included do
      cattr_accessor :ctx, :routes, :handler
      self.ctx    = EM::ZeroMQ::Context.new(1)
      self.routes = {}
      self.handler = Class.new do |k|
        k.send :attr_reader, :name, :new_events, :old_events, :event
        k.send :define_method, :initialize do |raw_data, tap, engine|
          data          = JSON.parse raw_data
          @tap          = tap
          @engine       = engine
          @name         = data['name']
          @new_events   = data['new_events'].map { |e| Event.new(e['event_type'], e['event']) }
          @old_events   = data['old_events'].map { |e| Event.new(e['event_type'], e['event']) }
          
          begin
            if @new_events.length + @old_events.length == 1
              @event = @new_events.first || @old_events.first
            end
          rescue => err
            puts "Rescuing error on single event: #{err.inspect}"
          end
        end
        
        k.send :define_method, :sendEvent do |event_data, event_type|
          raise "NO Reinject tap defined !" unless @tap
          begin
            @tap.send_msg [@engine.uri, "tap"].join("."), [event_data, event_type].to_json
          rescue => err
            puts "\n\n\n----------\nWTF: #{err.inspect}\n>#{err.backtrace.join("\n>")}"
          end
        end
        
        k.send :define_method, :handle! do
          begin
            puts "Calling handler for #{@name} -- defined? : #{self.respond_to?("on_#{@name}".to_sym)}"
            if self.respond_to? "on_#{@name}".to_sym
              res = self.send :before_each if self.respond_to? :before_each
              unless res == false
                self.send "on_#{@name}".to_sym
                self.send :after_each if self.respond_to? :after_each
              end
            else
              puts "No handler defined for #{@name}"
              self.send :catch_all if self.respond_to? :catch_all
            end
          rescue => err
            puts "\n\n\n\n---------"
            puts "Error handling event #{self.inspect}"
            puts "Error: #{err.inspect}"
          end
        end
      end
    end
    
    module ClassMethods
      
      def engine name, src_name, config_file="config/esper.cfg.xml"
        @engine ||= Hope::Engine.new name, config_file
        @engine.subscribe src_name
        @engine.subscribe name
        @engine.deploy "#{name}.epl"
      end
      
      def sub sock=nil, key="responses"
        @sub ||= self.ctx.connect ZMQ::SUB, sock, self
        @sub.subscribe key
      end
      
      def tap sock="ipc://hope"
        @tap ||= self.ctx.connect ZMQ::PUB, sock
      end
      
      def sendEvent event_data, data_type=nil
        channel = [@engine.uri, "tap"].join(".")
        @tap.send_msg(channel, [event_data, data_type].to_json)
      end
      
      def on_readable sock, messages
        key, ee = messages.map &:copy_out_string
        evt = self.handler.new(ee, @tap, @engine)
        puts "Dispatcher received event: #{key}, #{evt.name}"
        evt.handle!
      end
      
      def on statement_name, &block
        puts "Subscribing to responses on #{statement_name}"
        self.handler.send :define_method, "on_#{statement_name}".to_sym, &block
      end
      
      def before_each &block
        self.handler.send :define_method, :before_each, &block if block_given?
      end
      
      def after_each &block
        self.handler.send :define_method, :after_each, &block  if block_given?
      end
      
    end
    
  end
  
end