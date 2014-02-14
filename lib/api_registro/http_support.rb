require 'httparty'

module ApiRegistro
  
  module SupportedMethods
    POST = :post
    GET = :get
    PUT = :put
    DELETE = :delete
    ALL = [POST, GET, PUT, DELETE]
  end
  
  module HTTPSupport

    def http_request(resource_url, http_method, message={}, &block)
      if(ApiRegistro::SupportedMethods::ALL.include? http_method)
        response = HTTParty.send(http_method, resource_url, message)
        response = yield(response) if block_given?
        response
      else
        raise ArgumentError, "Unsupported HTTP method #{http_method}"
      end
    end
  end

end