# Load the rails application
require File.expand_path('../application', __FILE__)

Thingspeak::Application.configure do
	config.action_controller.perform_caching = true
	config.cache_store = :file_store, "#{Rails.root}/tmp/cache"

	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
		:port           => ENV['MAILGUN_SMTP_PORT'],
		:address        => ENV['MAILGUN_SMTP_SERVER'],
		:user_name      => ENV['MAILGUN_SMTP_LOGIN'],
		:password       => ENV['MAILGUN_SMTP_PASSWORD'],
		:domain         => ENV['APP_URL'],
		:authentication => :plain,
	}
end

# Initialize the rails application
Thingspeak::Application.initialize!
