require 'rubygems'
gem 'thoughtbot-shoulda'
require 'shoulda'
require File.expand_path(File.dirname(__FILE__) + '/../lib/a2ws')
include A2WS
  # black-box testing for generating signatures
  # reference:
  # http://docs.amazonwebservices.com/AWSECommerceService/2009-07-01/DG/index.html?rest-signature.html
class A2WSTest < Test::Unit::TestCase
  context "Amazon Authentication" do
    should "occur when finding items" do
      AAWS.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      AAWS.stubs(:build_signature).returns("SIGNATURE")
      expected_params = has_entries(
                          :query => has_entries(
                            :Timestamp => "2009-01-01T12:00:00Z",
                            :Signature => "SIGNATURE",
                            :Version => "2009-07-01"
                          )
                        )
      AAWS.expects(:get).with("/onca/xml", expected_params).returns(AAWSCannedResponse.asin_response)
      AAWS.find("0316769177")
    end

    should "occur when searching items" do
      AAWS.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      AAWS.stubs(:build_signature).returns("SIGNATURE")
      expected_params = has_entries(
                          :query => has_entries(
                            :Timestamp => "2009-01-01T12:00:00Z",
                            :Signature => "SIGNATURE",
                            :Version => "2009-07-01"
                          )
                        )
      AAWS.expects(:get).with("/onca/xml", expected_params).returns(AAWSCannedResponse.search_response)
      AAWS.search(:Title => "Ruby on Rails")
    end

    should "properly generate signatures" do
      AAWS.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      AAWS.stubs(:secret_key).returns("1234567890")
      AAWS.stubs(:default_params).returns({ :Service => "AWSECommerceService",
                                            :AWSAccessKeyId => "00000000000000000000",
                                            :ResponseGroup => "ItemAttributes,Offers,Images,Reviews"})

      assert_equal  "Nace+U3Az4OhN7tISqgs1vdLBHBEijWcBeCqL5xN9xg=",
                    AAWS.sign_request({ :Operation => "ItemLookup",
                                        :ItemId => "0679722769",
                                        :Version => "2009-01-06"})[:Signature]
    end

    should "properly generate signatures with overrides" do
      AAWS.stubs(:base_uri).returns("http://ecs.amazonaws.co.uk")
      AAWS.stubs(:timestamp).returns("2009-01-01T12:00:00Z")
      AAWS.stubs(:secret_key).returns("1234567890")
      AAWS.stubs(:default_params).returns({ :Service => "AWSECommerceService",
                                            :AWSAccessKeyId => "00000000000000000000",
                                            :ResponseGroup => "ItemAttributes,Offers,Images,Reviews,Variations"})

      assert_equal  "TuM6E5L9u/uNqOX09ET03BXVmHLVFfJIna5cxXuHxiU=",
                    AAWS.sign_request({ :Operation => "ItemSearch",
                                        :SearchIndex => "DVD",
                                        :Sort => "salesrank",
                                        :AssociateTag => "mytag-20",
                                        :Actor => "Johnny Depp",
                                        :Version => "2009-01-01"})[:Signature]
    end
  end
end
