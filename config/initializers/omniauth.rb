OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['751370074969569'], ENV['15e96b543bf8d79f97169fc413416271']
end