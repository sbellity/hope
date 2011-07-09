require File.expand_path('hope_client', File.dirname(__FILE__))

watch "client/(.*)\.(eco|coffee)" do |f|
  puts "Change detected to #{f} -- Rebuilding hope.js"
  HopeClient.new.build
end
