require "hmac"
require "hmac-sha2"
require 'cgi'

# reference:
# http://docs.amazonwebservices.com/AWSECommerceService/2009-07-01/DG/index.html?BasicAuthProcess.html
# http://docs.amazonwebservices.com/AWSECommerceService/2009-07-01/DG/index.html?Query_QueryAuth.html
module A2WS
  module Signature
    def sign_request(params)
      params.reverse_merge!(:Timestamp => timestamp, :Version => "2009-07-01")
      params.merge!(:Signature => build_signature(params, "GET"))
      params
    end

    private

    def timestamp
      Time.now.gmtime.strftime("%Y-%m-%dT%H:%M:%SZ")
    end

    def build_string_to_sign(params, http_verb)
      returning [] do |string_to_sign|
        string_to_sign << http_verb << self.base_uri.gsub(/^https?\:\/\//, "") << self.request_uri
        canonicalized_params = params.sort_by {|k,v| k.to_s }.map do |( k,v )|
          "#{aws_escape(k.to_s)}=#{aws_escape(v.to_s)}"
        end.join("&")
        string_to_sign << canonicalized_params
      end.join("\n")
    end

    def build_signature(params, http_verb)
      params.merge!(self.default_params)

      hmac = HMAC::SHA256.new(secret_key)
      hmac.update(build_string_to_sign(params, http_verb))

      Base64.encode64(hmac.digest).chomp
    end

    def aws_escape(string)
      CGI.escape(string).gsub("+", "%20").gsub("%7E", "~")
    end
  end
end

