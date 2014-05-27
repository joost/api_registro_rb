module ApiRegistro

  module Environments
    SANDBOX    = 'sandbox'
    PRODUCTION = 'production'
    ALL        = [SANDBOX, PRODUCTION]
  end

  def self.client(token, environment = Environments::PRODUCTION)
    ApiRegistro::Client.new(token, environment)
  end

end

require 'api_registro/version'
require 'api_registro/client'