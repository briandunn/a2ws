require 'spec'
require 'yaml'
require 'pp'
require 'rubygems'
gem 'mocha'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'a2ws'

Spec::Runner.configure do |config|
  def fixture file_name
    YAML.load(File.open(File.expand_path(File.dirname(__FILE__) + "/fixtures/#{file_name}.yml")))
  end
end
begin
  conf = YAML::load(open(ENV['HOME'] + '/.a2ws'))
  A2WS::Base.configure do |config|
    config.api_key = conf["access_key"]
    config.secret_key = conf["secret_key"]
  end
rescue
  puts "couldn't run live specs. if you want to actually hit up the api, put your key in a yaml file in your home folder.#{$!}"
end
