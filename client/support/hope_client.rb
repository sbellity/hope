require "fileutils"
require 'coffee-script'
require 'eco'

begin
  require 'rubygems'
  require 'growl'
rescue
  puts "growl gem not installed... run 'gem install growl' to get it"
end



class HopeClient
  
  def initialize path=File.expand_path("../app", File.dirname(__FILE__)), js_runtime = ExecJS::Runtimes::JavaScriptCore
    @base_path = path
    @js_runtime = js_runtime
  end
  
  def coffee_files
    ["#{@base_path}/hope.coffee"] + %w{ lib models collections helpers routers views }.map do |d|
      Dir.glob("#{@base_path}/#{d}/**/*.coffee")
    end.flatten.uniq.compact
  end

  def template_files
    Dir.glob("client/app/templates/**/*.eco")
  end

  def notify msg
    begin
      Growl.notify msg if defined?(Growl)
    rescue => err
      puts "Growl does not seem to be setup correctly: #{err.inspect}"
    end
  end

  def template file
    template_name = file.split("client/app/templates/").last.gsub(/\.eco$/, '')
    template_content = File.read(file)
    <<-EOC

  Hope.Templates['#{template_name}'] = #{Eco.compile(File.read(file))};

  EOC
  end
  
  
  
  def build target=nil
    begin
      target ||= File.expand_path "../../lib/hope/server/public/hope.js", File.dirname(__FILE__)
      ExecJS.runtime = @js_runtime
      File.open(target, 'w') do |hopejs|
        hopejs << "var Hope; window.Hope = Hope = {};"
        hopejs << "Hope.Templates = {};"
        template_files.map do |t| 
          puts "Compiling template: #{t}"
          hopejs << template(t)
        end
        hopejs << CoffeeScript.compile(coffee_files.map { |f| File.read(f) }.join("\n"))
      end
      notify "hope.js built !"
    rescue => err
      notify "Error building hope.js: \n#{err.to_s}"
    end
  end
  
end
