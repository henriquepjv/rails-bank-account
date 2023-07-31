# https://github.com/nikhgupta/omniauth-zoom/blob/master/lib/omniauth/strategies/zoom.rb

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Gia < OmniAuth::Strategies::OAuth2
      option :name, 'gia'

      option :client_options, {
        authorize_url: "/authorize",
        #site: Rails.env.production? ? "https://identity.iugu.com" : "https://identity.iugu.test"
        #site: "https://identity.iugu.com"
        site: "https://identity.iugu.test"
      }

      uid { info['id'] }

      def callback_url
        # sets the redirect callback url
        'http://localhost:3000/oauth2/callback'
      end
    end
  end
end
