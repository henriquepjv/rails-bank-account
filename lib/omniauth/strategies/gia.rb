# https://github.com/nikhgupta/omniauth-zoom/blob/master/lib/omniauth/strategies/zoom.rb

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Gia < OmniAuth::Strategies::OAuth2
      option :name, 'gia'

      option :client_options, {
        #token_url: "/oauth/token",
        #authorize_url: "/oauth/authorize",
        authorize_url: "/login",
        site: "https://console.iugu.test"
      }

      uid { info['id'] }
    end
  end
end
