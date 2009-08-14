module A2WS

  class ItemSearch < Base

    def self.find(keywords, search_index = :All, options = {})
      options.merge!({:Keywords => keywords, :SearchIndex => search_index})
      #result = get( request_uri, :query => sign_request(options) )
      result = APICache.get( request_uri + options.to_s) do 
        tmp = get( request_uri, :query => sign_request(options) )
        puts tmp.inspect 
        tmp
      end
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
