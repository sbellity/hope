require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hope::Statement do
  
  before :all do 
    @engine     = Hope::Engine.new "test-engine"
    @statement  = @engine.add_epl "select * from java.lang.String", "test-statement"
  end

  describe "forwared-methods" do
    
    it "should return its name" do
      @statement.name.should == "test-statement"
    end
    
    it "should return its epl" do
      @statement.text.should == "select * from java.lang.String"
    end
    
    it "should return its eventType" do
      @statement.event_type.getName.should == "java.lang.String"
    end
    
    it "should be started" do
      @statement.state.should == Hope::Statement::STARTED
      @statement.started?.should be_true
      @statement.stopped?.should be_false
    end
    
    it "should not be a pattern" do
      @statement.pattern?.should be_false
    end
    
    it "should return its last update time" do
      @statement.updated_at.should be_an_instance_of Time
    end
    
    it "should return its serializatble hash" do
      @statement.serializable_hash[:name].should == "test-statement"
    end
    
  end
    
end