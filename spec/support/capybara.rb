require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.default_driver = :poltergeist
  config.app_host = 'http://lvh.me'
  config.server_port = 45000
  config.ignore_hidden_elements = true
end

Capybara.server do |app, port|
  Puma::Server.new(app).tap { |server|
    server.add_tcp_listener '127.0.0.1', port
  }.run.join
end
