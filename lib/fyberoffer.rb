require "httparty"

##
#  SHA-1 Broken does not use it
# https://www.schneier.com/blog/archives/2005/02/sha1_broken.html  
require "digest/sha1"

class FyberOffer
  
  # Let's use class method than instance method Ruby world :-)
  class << self
    

    #
    # Only one public method
    #
    public
    def fyberofferreply(params)

      params.merge! fyberofferparams
      params = Hash[params.sort_by{|v,k| v}]
      params.merge! :hashkey => hashkey(params)
      
      response = fyberofferget(params)
      return [] unless ja? response

      response["offers"]
      
    end

    
    # 
    # The private class methods
    #
    private

    #
    # => Boolean
    #
    def ja?(response)
      response["code"] == "OK"
    end

    def fyberofferget(params)
      ##
      # Encryption please 
      #
      #puts params
      response = HTTParty.get("https://api.sponsorpay.com/feed/v1/offers.json", :query => params )
      
      unless checksig?(response)
        return { "code"  => "INVALID_RESPONSE_SIGNATURE" }
      end
      
      JSON.parse response.body
      
    end

    #
    # =>  Boolean
    #
    def checksig?(response)
      # SHA1 from Fyber site
      sig = response.headers["X-Sponsorpay-Response-Signature"]
      
      # Hash the whole resulting string using SHA1
      responsesig = Digest::SHA1.hexdigest "#{response.body}#{fyberofferapikey}"
      
      # let's compare signatures
      sig == responsesig

    end


    def fyberofferapikey
      "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
    end

    def fyberofferparams
      { 
        "appid" => 157,
        "format" => "json",
        "device_id" => "2b6f0cc904d137be2e1730235f5664094b83",
        "locale" => "de",
        "ip" => "109.235.143.113",
        "offer_types" => 112,
        "timestamp" => Time.now.to_i
      }
    end

    def hashkey(params)
      qstring = params.sort_by.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
      qstring << "&" << fyberofferapikey
      Digest::SHA1.hexdigest qstring
    end

  end

end
