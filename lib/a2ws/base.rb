module A2WS
  class Base
    include HTTParty
    extend Signature
    base_uri 'http://ecs.amazonaws.com'
    default_params :Service => 'AWSECommerceService'
    @@secret_key = ''

    class << self
    
      def configure
        yield self
      end
      
      def api_key=(key)
        default_params :AWSAccessKeyId => key
      end

      def cache_store=(cache_store)
        APICache.store = cache_store
      end

      def secret_key=(key)
        @@secret_key = key 
      end

      def secret_key
        @@secret_key
      end

      def request_uri
        '/onca/xml'
      end

      def request(options)
        APICache.get( request_uri + options.to_s) do 
          get( request_uri, :query => sign_request(options) )
        end
      end
      

      private

      def downcase_keys(hash)
        new_hash = {}
        hash.keys.each do |key|
          value = hash.delete(key)
          new_hash[downcase_key(key)] = value
          new_hash[downcase_key(key)] = downcase_keys(value) if value.is_a?(Hash)
          new_hash[downcase_key(key)] = value.each{|p| downcase_keys(p) if p.is_a?(Hash)} if value.is_a?(Array)
        end
        new_hash
      end
      
      def downcase_key(key)
        key.titlecase.downcase.gsub(' ', '_')
      end
    end
    
  end
  
end
