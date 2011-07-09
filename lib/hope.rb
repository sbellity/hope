require 'json'

require 'em-zeromq'

require 'hope/jars/esper-4.2.0.jar'
require 'hope/jars/commons-logging-1.1.1.jar'
require 'hope/jars/antlr-runtime-3.2.jar'
require 'hope/jars/cglib-nodep-2.2.jar'
require 'hope/jars/log4j-1.2.16.jar'

require 'hope/core_ext/object'


module Hope
  include Java
  
  def self.ctx
    @ctx ||= EM::ZeroMQ::Context.new(1)    
  end
  
  def self.pub
    @pub ||= ctx.bind ZMQ::PUB, 'ipc://hope'
  end
  
end

require "hope/version"
require "hope/engine"
require "hope/statement"
require "hope/source"
require "hope/source/base"
require "hope/source/twitter"

require "hope/listener/base"