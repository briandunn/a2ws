require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include A2WS
begin
  conf = YAML::load(open(ENV['HOME'] + '/.a2ws'))
  A2WS::Base.configure do |config|
    config.api_key = conf["access_key"]
    config.secret_key = conf["secret_key"]
  end
  describe "A2WS Operations" do

    describe ItemSearch do

      it "should find some items" do
        ItemSearch.find('Harry Potter', :Books).size.should_not == 0
      end
     
    end

    describe "signing" do
      ItemSearch.find('Harry Potter', :Books).size.should_not == 0
    end

  end
rescue
  puts "couldn't run live specs. if you want to actually hit up the api, put your key in a yaml file in your home folder.#{$!}"
end

