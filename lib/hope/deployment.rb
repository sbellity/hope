module Hope
  class DeploymentResult
    
    extend Forwardable
    
    attr_reader :depl_result
    
    def initialize depl_result
      @depl_result = depl_result
    end
    
    
  end
end