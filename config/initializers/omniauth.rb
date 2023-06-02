#module OmniAuth
#  module Strategies
#    # tell OmniAuth to load our strategy
#    autoload :Gia, 'lib/gia_strategy'
#  end
#end

# List of available strategies -> https://github.com/omniauth/omniauth/wiki/List-of-Strategies

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :httpbasic, "https://console.iugu.test"
  provider :gia, 'app_id', 'app_secret'
  #provider :gia, "https://console.iugu.test/login"
end
