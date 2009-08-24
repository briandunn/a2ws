module A2WS
  class Base
    include HTTParty
    extend Signature
    base_uri 'http://ecs.amazonaws.com'
    default_params :Service => 'AWSECommerceService', :Operation => 'ItemSearch'
    @@secret_key = ''
    
    def self.configure
      yield self
    end
    
    def self.api_key=(key)
      default_params :AWSAccessKeyId => key
    end

    def self.cache_store=(cache_store)
      APICache.store = cache_store
    end

    def self.secret_key=(key)
      @@secret_key = key 
    end

    def self.secret_key
      @@secret_key
    end

    def self.request_uri
      '/onca/xml'
    end

    private

    def self.downcase_keys(hash)
      new_hash = {}
      hash.keys.each do |key|
        value = hash.delete(key)
        new_hash[downcase_key(key)] = value
        new_hash[downcase_key(key)] = downcase_keys(value) if value.is_a?(Hash)
        new_hash[downcase_key(key)] = value.each{|p| downcase_keys(p) if p.is_a?(Hash)} if value.is_a?(Array)
      end
      new_hash
    end
    
    def self.downcase_key(key)
      key.titlecase.downcase.gsub(' ', '_')
    end
    
  end
  
end
