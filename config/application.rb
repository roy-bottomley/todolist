require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Todolist
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.action_mailer.raise_delivery_errors = false
    config.time_zone = 'UTC'

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.default :content_type => "text/plain"


#ActionMailer::Base.smtp_settings = {
#    :address              => "mail.foo.com",
#    :port                 => 587,
#    :domain               => "foo.com",
#    :user_name            => "addy@foo.com",
#    :password             => "foofoo",
#    :authentication       => "plain",
#    :enable_starttls_auto => true,
#    :openssl_verify_mode  => 'none'
#}

    ActionMailer::Base.smtp_settings = {
        #:address => "mail.traintobehappy.com",
        #:port => 587,
        #:authentication => "plain",
        #:user_name => "admin",
        #:password => "m5a99x",
        #:enable_starttls_auto => true,
        #
        # :address   => "smtp.mandrillapp.com",
        # :port      => 25, # ports 587 and 2525 are also supported with STARTTLS
        # :enable_starttls_auto => true, # detects and uses STARTTLS
        # :user_name => "roy.bottomley@virginmedia.com",
        # :password  => "dkAUgE5khJBLQ_iCIz9Unw", # SMTP password is any valid API key
        # :authentication => 'login', # Mandrill supports 'plain' or 'login'
        # :domain => 'www.tacticalfootball.com', # your domain to identify your server when connecting

        :authentication  => 'plain', # Mandrill supports 'plain' or 'login'
        :address   => "smtp.mailgun.org",
        :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
        :domain => 'tacticalfootball.com', # your domain to identify your server when connecting
        :enable_starttls_auto => true, # detects and uses STARTTLS
        :user_name => "postmaster@tacticalfootball.com",
        :password  => ENV["PASSWORD"]

    }


#ActionMailer::Base.perform_deliveries = true #try to force sending in development
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.default :charset => "utf-8"


  end

end
