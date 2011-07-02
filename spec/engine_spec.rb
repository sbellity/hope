require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hope::Engine do
  
  before :all do 
    @engine = Hope::Engine.new "test-engine"
  end

  describe "creating & registering" do
    
    it "should have the right uri" do
      @engine.uri.should == 'test-engine'
    end
    
    it "should have only one engine registered" do
      Hope.engines.keys.should == ['test-engine']
    end
    
    it "should properly register a new engine" do
      e2 = Hope::Engine.new "another-engine"
      Hope.engines.keys.should include('test-engine')
      Hope.engines.keys.sort.should == ['another-engine', 'test-engine']
    end
    
    it "new engine with no name should be default" do
      default = Hope::Engine.new
      default.uri.should == "default"
    end
    
    it "should unregister properly an engine on destroy" do
      e2 = Hope::Engine.new "to-destroy"
      Hope.engines['to-destroy'].should_not be_nil
      e2.destroy
      e2.destroyed?.should be_true
      Hope.engines['to-destroy'].should be_nil
    end
    
    it "sould retrive an engine from its name" do
      Hope::Engine.get('test-engine').uri.should == "test-engine"
    end
    
    it "should keep track of all engines" do
      com.espertech.esper.client.EPServiceProviderManager.getProviderURIs.to_a.sort.should == Hope.engines.keys.sort
    end
    
  end
  
  describe "manage statements" do
    
    it "should be able to add a new unnamed epl statement" do
      st = @engine.add_epl "select * from java.lang.String"
      @engine.statement_names.should include(st.getName)
      st.isPattern.should be_false
    end
    
    it "should be able to add a new named epl statement" do
      name = "all_strings"
      @engine.add_epl "select * from java.lang.String", name
      @engine.statement_names.should include(name)
    end

    it "should be able to add a new pattern" do
      st = @engine.add_pattern "every java.lang.String"
      @engine.statement_names.should include(st.getName)
      st.isPattern.should be_true
    end
    
  end
  
end