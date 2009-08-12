require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include A2WS

describe "A2WS Operations" do

  describe ItemSearch do

    it "should survive a search that returns a single result" do
      ItemSearch.expects(:get).returns(fixture :single_item_response)
      ItemSearch.find('not used')
    end

    it "should return an empty array when there aint no results" do 
      ItemSearch.expects(:get).returns(fixture :empty_response)
      ItemSearch.find( "not used" ).should == []
    end

  end

end
