module ApiRegistro
  class Client
    include ApiRegistro::HTTPSupport
    
    def initialize(token, environment)
      @token = token
      @env   = environment
    end
    
    def create_contact(opts={})
      message = {
        headers:    { "Accept"        => "application/json", 
                      "Content-Type"  => "application/json",
                      "Authorization" => "Token #{@token}"
                    },
        body: opts.to_json
      }
      request(url_for(:create_contact), ApiRegistro::SupportedMethods::POST, message)
    end
    
    def find_contact(document_number)
      message = {
        headers:    { "Accept" => "application/json", "authorization" => @token }
      }
      request(url_for(:find_contact, document_number), ApiRegistro::SupportedMethods::GET, message)
    end
    
    def register_domain(domain, document_number)
      message = {
        headers:    { "Accept"        => "application/json", 
                      "Content-Type"  => "application/json",
                      "Authorization" => "Token #{@token}"
                    },
        body: {document: document_number}.to_json
      }
      request(url_for(:register_domain, domain), ApiRegistro::SupportedMethods::POST, message)
    end
    
    def find_domain(domain_name)
      message = {
        headers:    { "Accept" => "application/json", "authorization" => @token }
      }
      request(url_for(:find_domain, domain_name), ApiRegistro::SupportedMethods::GET, message)
    end
    
    private
    
    def request(url, http_method, message)
      response = http_request(url, http_method, message)
      if(response.code == 200)
        response.body
      else
        nil
      end
    end
    
    def uris
      {
          create_contact:  "contacts/",
          find_contact:    "contacts/%s/",
          register_domain: "domains/%s/buy/",
          find_domain:     "domains/?search=%s"
      }
    end
    
    def base_url
      @env == ApiRegistro::Environments::PRODUCTION ? 
                    "http://apiregistro.com.br/api/v1" : 
                    "http://sandbox.apiregistro.com.br/api/v1"
    end
    
    def url_for(resource, *params)
      uri = uris[resource] % params
      "#{base_url}/#{uri}"
    end
    
  end
end
