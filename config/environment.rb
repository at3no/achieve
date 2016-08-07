# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

config.action_mailer.default_url_options = { host: 'evening-fjord-65188.herokuapp.com'}
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings =
  {
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: "heroku.com",
    address: "smtp.sendgrid.net",
     port: 587,
     authentication: :plain,
    enable_starttls_auto: true
  }