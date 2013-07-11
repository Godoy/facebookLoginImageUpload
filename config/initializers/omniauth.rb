OmniAuth.config.logger = Rails.logger
#OmniAuth.config.on_failure = UsersController.action(:oauth_failure)


FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret']
end

