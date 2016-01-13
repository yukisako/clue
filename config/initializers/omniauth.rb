Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :facebook,"App ID","App Secret",
           :scope => 'email,read_stream', display => 'popup'
end 