require 'forwardable'

module Hope
  
  class Statement
    
    java_import com.espertech.esper.client.EPStatementState
    
    %w{ STARTED FAILED DESTROYED STOPPED }.each do |c|
      const_set(c, EPStatementState.valueOf(c))
    end
    
    extend Forwardable
    
    attr_reader :ep_statement
    
    def_delegator :@ep_statement, :stop,    :stop
    def_delegator :@ep_statement, :start,   :start
    def_delegator :@ep_statement, :destroy, :destroy
    
    def_delegator :@ep_statement, :getName,                 :name
    def_delegator :@ep_statement, :getEventType,            :event_type
    def_delegator :@ep_statement, :getText,                 :text
    def_delegator :@ep_statement, :getState,                :state
    def_delegator :@ep_statement, :getUserObject,           :user
    def_delegator :@ep_statement, :getAnnotations,          :annotations
    def_delegator :@ep_statement, :getServiceIsolated,      :service_isolated

    def_delegator :@ep_statement, :isPattern,   :pattern?

    def_delegator :@ep_statement, :isStarted,   :started?
    def_delegator :@ep_statement, :isStopped,   :stopped?
    def_delegator :@ep_statement, :isDestroyed, :destroyed?

    def_delegator :@ep_statement, :addListener, :add_listener
    def_delegator :@ep_statement, :getUpdateListeners, :get_listeners
    def_delegator :@ep_statement, :removeListener, :remove_listener
    def_delegator :@ep_statement, :removeAllListeners, :remove_all_listeners
    
    
    def to_s
      "[#{name}:#{event_type}] (#{state}) : #{text}"
    end
    
    def initialize ep_statement
      @ep_statement = ep_statement
    end

    def updated_at
      Time.at(@ep_statement.getTimeLastStateChange / 1000)
    end
    
    def serializable_hash
      {
        :id           => name,
        :name         => name,
        :text         => text,
        :updated_at   => updated_at,
        :state        => state.to_s,
        :is_pattern   => pattern?,
        :event_type   => event_type.getName,
        :is_destroyed => destroyed?,
        :listeners    => get_listeners.map { |l| l.serializable_hash  }
      }
    end
    
    def to_json
      serializable_hash.to_json
    end
    
  end
  
end