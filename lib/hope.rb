require 'json'

require 'hope/jars/esper-4.2.0.jar'
require 'hope/jars/commons-logging-1.1.1.jar'
require 'hope/jars/antlr-runtime-3.2.jar'
require 'hope/jars/cglib-nodep-2.2.jar'
require 'hope/jars/log4j-1.2.16.jar'


module Hope
  include Java
end

require "hope/version"
require "hope/engine"