require 'json'

require 'em-zeromq'

require 'hope/jars/esper-4.2.0.jar'
require 'hope/jars/commons-logging-1.1.1.jar'
require 'hope/jars/antlr-runtime-3.2.jar'
require 'hope/jars/cglib-nodep-2.2.jar'
require 'hope/jars/log4j-1.2.16.jar'
require 'hope/jars/msgpack-0.6.0-devel.jar'

java_import org.msgpack.MessagePack

require 'hope/core_ext/object'

require "hope/version"
require "hope/engine"
require "hope/statement"
require "hope/event_type"
require "hope/source"
require "hope/source/base"
require "hope/source/twitter"

require "hope/listener/base"

require 'hope/server'

module Hope
  include Java

  def self.ctx
    @ctx ||= EM::ZeroMQ::Context.new(1)
  end

  def self.pub
    @pub ||= ctx.bind ZMQ::PUB, "ipc://#{self.channel}"
  end
  
  def self.channel
    @channel_name || "hope"
  end

  def self.configure config_file, &block
    config = YAML::load_file(config_file)
    
    @channel_name = config["channel"] || "hope"

    config["engines"].each do |uri, econf|
      # Create engine
      e = Hope::Engine.new(uri)

      # Subscribe to named sources
      econf['subscriptions'].each do |sub|
        e.subscribe(sub)
      end

      # Add and configure Statements
      econf['statements'].each do |sn, st|
        s = e.add_epl st['epl'], sn
        # s.add_listener Hope::Listener::Base.new
      end
    end unless config["engines"].nil?

    # Add Sources
    config["sources"].each do |sn, src_opts|
      source = Hope::Source::Twitter.new(sn, src_opts)
    end unless config["sources"].nil?

    yield if block_given?
  end

end

