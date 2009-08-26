require File.join(File.dirname(__FILE__), 'spec_helper')
include A2WS
describe ItemSearch do
  describe "when response group images is included" do
    it "should return items that contain images" do
      ItemSearch.expects(:get).returns(Crack::XML.parse fixture('item_search_with_images.xml'))
      images = ItemSearch.find( 'ignored').first.images
      images.should be_an_instance_of(Array)
      for image in images
        image.should be_an_instance_of(Image)
        lambda { URI.parse(image.url) }.should_not raise_error
      end
    end
  end

  it "should survive a search that returns a single result" do
    ItemSearch.expects(:request).returns(yaml_fixture :single_item_response)
    ItemSearch.find('not used')
  end

  it "should return an empty array when there aint no results" do 
    ItemSearch.expects(:request).returns(yaml_fixture :empty_response)
    ItemSearch.find( "not used" ).should == []
  end

end
