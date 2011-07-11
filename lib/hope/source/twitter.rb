require 'twitter/json_stream'
require "logger"
require "json"
require 'ostruct'



module Hope
  class Source::Twitter < Hope::Source::Base
    
    class TwitterUser < Hope::EventType
      def self.properties
        {
          "protected"                           => "bool",
          "default_profile"                     => "bool",
          "contributors_enabled"                => "bool",
          "profile_text_color"                  => "string",
          "name"                                => "string",
          "default_profile_image"               => "bool",
          "profile_sidebar_fill_color"          => "string",
          "id_str"                              => "string",
          "profile_background_tile"             => "bool",
          "utc_offset"                          => "string",
          "friends_count"                       => "int",
          "profile_image_url"                   => "string",
          "is_translator"                       => "bool",
          "following"                           => "bool",
          "description"                         => "string",
          "location"                            => "string",
          "follow_request_sent"                 => "string",
          "verified"                            => "bool",
          "profile_link_color"                  => "string",
          "followers_count"                     => "int",
          "screen_name"                         => "string",
          "profile_sidebar_border_color"        => "string",
          "url"                                 => "string",
          "show_all_inline_media"               => "bool",
          "geo_enabled"                         => "bool",
          "time_zone"                           => "string",
          "id"                                  => "long",
          "notifications"                       => "bool",
          "profile_use_background_image"        => "bool",
          "favourites_count"                    => "int",
          "created_at"                          => "string",
          "listed_count"                        => "int",
          "profile_background_image_url_https"  => "string",
          "profile_background_color"            => "string",
          "lang"                                => "string",
          "statuses_count"                      => "int",
          "profile_background_image_url"        => "string",
          "profile_image_url_https"             => "string"
        }
      end
    end

    class Tweet < Hope::EventType
      def self.properties
        {
          "place"                               => "string",
          "user"                                => "TwitterUser",
          "in_reply_to_user_id"                 => "long",
          "retweet_count"                       => "int",
          "id_str"                              => "string",
          "geo"                                 => "string",
          "favorited"                           => "bool",
          "text"                                => "string",
          "in_reply_to_status_id_str"           => "string",
          "in_reply_to_screen_name"             => "string",
          "in_reply_to_user_id_str"             => "string",
          "coordinates"                         => "string",
          "truncated"                           => "bool",
          "contributors"                        => "string",
          "retweeted"                           => "bool",
          "id"                                  => "long",
          "source"                              => "string",
          "created_at"                          => "string",
          "in_reply_to_status_id"               => "long"
        }
      end
    end
    
    def self.event_types
      [ TwitterUser, Tweet ]
    end
    
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
        # @logger.info(item)
        @received[:success] += 1
        tweet = JSON.parse item
        Hope.pub.send_msg name, { "data" => tweet, "type" => "Tweet" }.to_json
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