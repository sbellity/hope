module Hope 
  class Source::Sub < Hope::Source::Base
    
    attr_reader :received
    
    def initialize name, opts={}
      @name = name
      @socket = opts["socket"] || "ipc://hope"
      @event_type = opts["event_type"]
      @received = { :success => 0, :errors => 0, :latest_error => "" }
      @sub = Hope.ctx.bind ZMQ::SUB, @socket, self
      @sub.subscribe ""
      Hope::Source.register self
    end
    
    def on_readable(socket, messages)
      @received[:success] += 1
      src, evt = messages.map &:copy_out_string
      Hope.pub.send_msg src, evt
    end
  end
end