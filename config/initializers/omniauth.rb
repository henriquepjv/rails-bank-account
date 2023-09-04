#module OmniAuth
#  module Strategies
#    # tell OmniAuth to load our strategy
#    autoload :Gia, 'lib/gia_strategy'
#  end
#end

# List of available strategies -> https://github.com/omniauth/omniauth/wiki/List-of-Strategies

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :developer if Rails.env.development?
  #provider :httpbasic, "https://console.iugu.test"
  #provider :gia, '59W8ABJ2HVveomh3jU06Zi', 'f6e20107236b556cb8d108db842be6247da50c4d520cef3434df16b51aa288e63420d189'
  #provider :gia, "https://console.iugu.test/login"
  # DEV:
  provider :gia, '2fTTzy4v4nrfSM0Myfzzrf', '1ebed5ace731b55464937c04a84ce776ff394463ce4e8231eda4a1aa9b03d281cc524d20'
  # PROD:
  #provider :gia, '6ytGxOU0hwx9HsRAK2xja0', '2e4784bd3c003cf4a908243af06df41eed9dcdfa1c53ecf7d32d2ce6292b5a2cef47807f'
end
