# ApiRegistro

A simple client for APIRegistro Domain registration API service (http://apiregistro.com.br).

## Installation

Add this line to your application's Gemfile:

    gem 'api_registro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_registro

## Usage

    client = ApiRegistro.client("INSERT YOUR TOKEN HERE") # uses production environment.
    client = ApiRegistro.client("INSERT YOUR TOKEN HERE", ApiRegistro::Environments::SANDBOX) #uses sandbox environment for testing purposes.
    h = {name: "John  Doe", document: "111.111.111-11", email: "john@email.com"}
    response = client.create_contact(h) # creates a contact
    contact_json = client.find_contact("111.111.111-11") # retrieves a contact using contact's CPF.
    response = client.domain("mydomain.com.br") # retrieves domain registration information
    response = client.register_domain("mydomain.com.br", "111.111.111-11") # register domain testejoopp.com to contact assigned to CPF 111.111.111-11

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
