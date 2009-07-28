require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include A2WS
begin
  config = YAML::load(open(ENV['HOME'] + '/.a2ws'))
  access_key = config["access_key"]

  A2WS::Base.configure do |config|
    config.api_key = access_key
  end
  describe "A2WS Operations" do

    describe ItemSearch do

      it "should find some items" do
        ItemSearch.find('Harry Potter', :Books).size.should_not == 0
      end

    end

  end
rescue
  puts "couldn't run live specs. if you want to actually hit up the api, put your key in a yaml file in your home folder."
end

