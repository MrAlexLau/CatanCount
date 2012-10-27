if not Rails.env.production?
  APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

  ENV["facebook_key"] = APP_CONFIG["facebook_key"]
  ENV["facebook_secret"] = APP_CONFIG["facebook_secret"]
  ENV["google_key"] = APP_CONFIG["google_key"]
  ENV["google_secret"] = APP_CONFIG["google_secret"]
  ENV["secret_token"] = APP_CONFIG["secret_token"]
end