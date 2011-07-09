require File.expand_path('hope_client', File.dirname(__FILE__))

namespace :client do
  
  desc "Build a single file version of hope-web client app"
  task :build do
    HopeClient.new.build
  end
  
  task :watch do
    Kernel.system "watchr #{File.expand_path("client.watchr", File.dirname(__FILE__))}"
  end
end