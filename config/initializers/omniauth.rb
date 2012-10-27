Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['facebook_key'], ENV['facebook_secret']
  provider :google_oauth2, ENV['google_key'], ENV['google_secret']
end