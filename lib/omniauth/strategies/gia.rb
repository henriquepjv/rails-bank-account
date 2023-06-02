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
        site: Rails.env.production? ? "https://console.iugu.com" : "https://console.iugu.test"
      }

      uid { info['id'] }

      def callback_url
        # check why gia dont redirect to this url
        'http://localhost:3000/auth/gia/callback'
      end
    end
  end
end
