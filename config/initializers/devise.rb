Devise.setup do |config|
  # config.mailer_sender = 'midwhite.development@gmail.com'
  config.mailer_sender = ENV['GMAIL_ADDR']

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # OAUTH_CONFIG = YAML.load_file("#{Rails.root}/config/omniauth.yml")[Rails.env].symbolize_keys!
  # config.omniauth :facebook, OAUTH_CONFIG[:facebook]['key'], OAUTH_CONFIG[:facebook]['secret'], scope: 'email,publish_stream,user_birthday'

  config.omniauth(
    :facebook,
      ENV['FB_APP_ID'],
      ENV['FB_APP_SECRET'],
      scope: 'email',
      info_fields: 'name,first_name,last_name,email,age_range'
  )
end
