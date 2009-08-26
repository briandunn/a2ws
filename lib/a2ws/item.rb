module A2WS

  class Item
    include Methodize
  
    def item_attributes
      ItemAttributes.new @data_hash["item_attributes"]
    end
     
    def offers 
      Offers.new @data_hash["offers"]
    end
    
    def images
      if image_set = @data_hash['image_sets']['image_set']
        Base.downcase_keys(image_set).reject do |k,v|
          !(k =~ /_image$/) 
        end.map do |size, data| 
          Image.new(size, data)
        end
      else
        ImageSearch.find(@data_hash["asin"])
      end
    end
  
  end
  
  class ItemAttributes
    include Methodize
    
  end

  class Offers
    include Methodize
  end
  
end
