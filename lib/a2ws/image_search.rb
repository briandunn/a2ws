module A2WS


  class ImageSearch < Base
    
    def self.find(item) 
      items = request(:ItemId => item, :Operation => "ItemLookup", :ResponseGroup => "Images")
      items = items['ItemLookupResponse']['Items']
      if items["Request"]['IsValid'] == 'True'
        items["Item"].delete("ImageSets")
        items["Item"].delete("ASIN")
        downcase_keys(items["Item"]).collect { |size, data| Image.new(size, data) }
      else
        raise items['Request']['Errors']['Error']['Message']
      end
    end
    
  end
  
  
end
