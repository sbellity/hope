require 'json'
require "digest/md5"

require 'em-zeromq'

require 'hope/jars/esper-4.3.0.jar'
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
require "hope/source/sub"
# require "hope/source/twitter"

require "hope/listener/base"

require 'hope/server'

module Hope
  include Java

  def self.ctx
    @ctx ||= EM::ZeroMQ::Context.new(1)
  end

  def self.pub
    @pub ||= ctx.bind ZMQ::PUB, 'ipc://hope'
  end

  def self.config
    @config ||= {}
  end

  def self.configure config_file, &block
    @config = YAML::load_file(config_file)
    Hope::Source
    # Add Sources
    @config["sources"].each do |sn, src_opts|
      begin
        src_type = src_opts.delete("type")
        src_klass = src_type.constantize
        source = src_type.constantize.new(sn, src_opts)
      rescue => err
        puts "Error creating source #{src_type}: #{err}"
        raise err
      end
    end unless config["sources"].nil?
    
    if @config["reload_config"].to_i > 0
      EM::PeriodicTimer.new(@config["reload_config"].to_i) do
        new_config_hash = Digest::MD5.hexdigest(open(config_file).read)
        self.load_engines(YAML::load_file(config_file)['engines']) if new_config_hash != @config_hash
        @config_hash = new_config_hash
      end
    else
      self.load_engines @config['engines'] unless @config['engines'].nil?
    end

    yield if block_given?
  end
  
  def self.load_engines engines_config
    engines_config.each do |uri, econf|
      if e = Hope::Engine.get(uri)
        e.stop
        e.reset
      else
        # Create engine
        puts "Creating engine with config: #{@config['engines_cfg']}"
        e = Hope::Engine.new(uri, @config['engines_cfg'])
        # Subscribe to named sources
        econf['subscriptions'].each do |sub|
          e.subscribe(sub)
        end if econf['subscriptions']
      end


      # Add and configure Statements
      econf['statements'].each do |sn, st|
        s = e.add_epl st['epl'], sn
        st['listeners'].each do |listener_name, listener_opts|
          listener_klass = listener_opts.delete('class').constantize
          listener_args = listener_opts.delete('args')
          s.add_listener listener_klass.new("#{listener_name}-#{rand(1000000)}", *listener_args)
        end if st['listeners']
      end if econf['statements']
      e.start
    end unless engines_config.nil?
  end

end

