require 'rest-client'
require 'json'

response = RestClient.get "https://mailtrap.io/api/v1/inboxes.json?api_token=#{ENV['MAILTRAP_API_TOKEN']}"
first_inbox = JSON.parse(response)[0] # get first inbox

Thingspeak::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # required by devise
  config.action_mailer.default_url_options = { :host => "#{ENV['APP_URL']}" }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  :user_name => first_inbox['username'],
  :password => first_inbox['password'],
  :address => first_inbox['domain'],
  :domain => first_inbox['domain'],
  :port => first_inbox['smtp_ports'][0],
  :authentication => :plain
}
  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  config.eager_load = false

  config.assets.prefix = "/dev-assets"

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  config.assets.debug = true

end

