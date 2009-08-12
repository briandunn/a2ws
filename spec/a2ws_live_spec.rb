require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include A2WS
describe "A2WS Operations" do

  describe ItemSearch do

    it "should find some items" do
      ItemSearch.find('Harry Potter', :Books).size.should_not == 0
    end
   
  end

  describe Item do
    it "should have an image" do
      ItemSearch.find('Harry Potter', :Books).first.images.size.should_not == 0
    end

  end

  describe "Amazon Authentication" do
    it "occur when finding items" do
      ItemSearch.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      #ItemSearch.stubs(:build_signature).returns("SIGNATURE")
      expected_params = has_entries(
                          :query => has_entries(
                            :Timestamp => "2009-01-01T12:00:00Z",
                            :Signature => "SIGNATURE",
                            :Version => "2009-07-01"
                          )
                        )
      ItemSearch.expects(:get).with("/onca/xml", expected_params).returns(AAWSCannedResponse.asin_response)
      ItemSearch.find("0316769177")
    end

    it "occur when searching items" do
      ItemSearch.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      #ItemSearch.stubs(:build_signature).returns("SIGNATURE")
      expected_params = has_entries(
                          :query => has_entries(
                            :Timestamp => "2009-01-01T12:00:00Z",
                            :Signature => "SIGNATURE",
                            :Version => "2009-07-01"
                          )
                        )
      ItemSearch.expects(:get).with("/onca/xml", expected_params).returns(AAWSCannedResponse.search_response)
      ItemSearch.search(:Title => "Ruby on Rails")
    end

    it "properly generate signatures" do
      ItemSearch.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      ItemSearch.stubs(:secret_key).returns("1234567890")
      ItemSearch.stubs(:default_params).returns({ :Service => "AWSECommerceService",
                                            :AWSAccessKeyId => "00000000000000000000",
                                            :ResponseGroup => "ItemAttributes,Offers,Images,Reviews"})
      ItemSearch.sign_request({ :Operation => "ItemLookup",
                          :ItemId => "0679722769",
                          :Version => "2009-01-06"})[:Signature].should == "Nace+U3Az4OhN7tISqgs1vdLBHBEijWcBeCqL5xN9xg="
    end

    it "properly generate signatures with overrides" do
      ItemSearch.stubs(:base_uri).returns("http://ecs.amazonaws.co.uk")
      ItemSearch.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      ItemSearch.stubs(:secret_key).returns("1234567890")
      ItemSearch.stubs(:default_params).returns({ :Service => "AWSECommerceService",
                                            :AWSAccessKeyId => "00000000000000000000",
                                            :ResponseGroup => "ItemAttributes,Offers,Images,Reviews,Variations"})

      ItemSearch.sign_request({ :Operation => "ItemSearch",
                          :SearchIndex => "DVD",
                          :Sort => "salesrank",
                          :AssociateTag => "mytag-20",
                          :Actor => "Johnny Depp",
                          :Version => "2009-01-01"})[:Signature].should == "TuM6E5L9u/uNqOX09ET03BXVmHLVFfJIna5cxXuHxiU="
    end
  end
end

