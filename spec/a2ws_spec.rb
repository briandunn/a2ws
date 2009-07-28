require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include A2WS

describe "A2WS Operations" do

  describe ItemSearch do

    it "should survive a search that returns a single result" do
      ItemSearch.should_receive(:get).and_return(YAML.load(File.open(File.expand_path(File.dirname(__FILE__) + '/fixtures/single_item_response.yml'))))
      ItemSearch.find('not used')
    end

  end

end
