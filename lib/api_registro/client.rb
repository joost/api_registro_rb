require 'httparty'
module ApiRegistro

  class Error < StandardError
    MESSAGES = {}
    attr_reader :response

    def initialize(response)
      # TODO: ArgumentError if not correct response class.
      @response = response
    end

    def message
      message = nil
      if response
        message = "Got wrong response code (#{response.code} - #{response.message})!"
        message = "#{response.parsed_response['detail']} (Response code #{response.code})" if response && response.parsed_response.is_a?(Hash)
      else
        message = super
      end
      return message
    end
  end

  # class RegisterError < Error
  #   MESSAGES = {
  #     401 => 'Authentication credentials were not provided',
  #     402 => 'Insufficient credits',
  #     403 => 'This account can not manage the reported contact',
  #     404 => 'Domain already registered or may not be registered via Registro.br',
  #     502 => 'Registro.br is not available at this time'
  #   }
  # end

  class Client
    include HTTParty

    def initialize(token, environment)
      @token = token
      @env   = environment
    end

    def contacts
      get('/contacts')
    end

    def contact(document_number)
      get("/contacts/#{document_number}/")
    end

    def search_contacts(document_number)
      get('/contacts', query: {document: document_number})
    end

    def create_contact(contact_hash)
      post('/contacts', body: contact_hash.to_json)
    end

    def domains
      get('/domains')
    end

    def domain(domain)
      get("/domains/#{domain}")
    end

    def search_domains(domain)
      get('/domains', query: {search: domain})
    end

    def register_domain(domain, document_number)
      post("/domains/#{domain}/buy/", body: {document: document_number}) # Ending slash in url is IMPORTANT. Otherwise you get: "Method 'GET' not allowed"
    # rescue Error => error
    #   raise RegisterError.new(error.response) # FIXME: Better way?
    end

    def get(path, options = {})
      options[:base_uri] ||= base_uri
      options[:headers] ||= {}
      options[:headers].reverse_merge!('Accept' => 'application/json', 'Authorization' => "Token #{@token}")
      # puts "GET path: #{path}, options: #{options.inspect}"
      parse_response(self.class.get(path, options))
    end

    def post(path, options = {})
      options[:base_uri] ||= base_uri
      options[:headers] ||= {}
      options[:headers].reverse_merge!('Accept' => 'application/json', 'Authorization' => "Token #{@token}", 'Content-Type' => 'application/json')
      # puts "POST path: #{path}, options: #{options.inspect}"
      parse_response(self.class.post(path, options))
    end

    def base_uri
      @env == ApiRegistro::Environments::PRODUCTION ?
                    'http://apiregistro.com.br/api/v1' :
                    'http://sandbox.apiregistro.com.br/api/v1'
    end

  private

    def parse_response(response)
      if response.success?
        response.parsed_response
      else
        raise ApiRegistro::Error.new(response)
      end
    end

  end
end
