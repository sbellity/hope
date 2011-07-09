require 'twitter/json_stream'
require "logger"
require "json"

module Hope
  class Source::Twitter < Hope::Source::Base
    
    def initialize(name, opts={})
      
      @logger = Logger.new("tmp/#{name}.json")
      
      EM::PeriodicTimer.new(1) do
        puts "#{@received[:success]} tweets Received from Twitter::#{name}"
      end
      
      @name = name
      @received = { :success => 0, :errors => 0, :latest_error => "" }
      @options = {}.merge(opts)
      
      stream = Twitter::JSONStream.connect(
        :path    => "/1/statuses/filter.json?track=#{@options["track"]}",
        :auth    => "#{@options["login"]}:#{@options["password"]}"
      )

      stream.each_item do |item|
        @logger.info(item)
        @received[:success] += 1
        tweet = JSON.parse item
        Hope.pub.send_msg name, tweet["text"]
      end

      stream.on_error do |message|
        @received[:errors] += 1
        puts "Error: #{message}"
      end

      stream.on_max_reconnects do |timeout, retries|
        @received[:latest_error] = "Max reconnect: #{timeout} || retried #{retries} times..."
      end
      
      Hope::Source.register self
    end

  end 
end