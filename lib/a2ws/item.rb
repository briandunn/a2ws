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
      ImageSearch.find(@data_hash["asin"])
    end
  
  end
  
  class ItemAttributes
    include Methodize
    
  end

  class Offers
    include Methodize
  end
  
end
