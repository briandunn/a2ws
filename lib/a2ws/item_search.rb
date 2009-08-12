module A2WS

  class ItemSearch < Base

    def self.find(keywords, search_index = :All, options = {})
      options.merge!({:Keywords => keywords, :SearchIndex => search_index})
      query = sign_request(options)
      result = get( request_uri, :query => query )

      items = result["ItemSearchResponse"]["Items"]
      if items['Request']['IsValid'] == 'True'
        [ items['Item'] ].flatten.compact.collect do |i|
          Item.new downcase_keys(i)
        end
      else
        raise items['Request']['Errors']['Error']['Message']
      end
    end
    
  end
  
end
