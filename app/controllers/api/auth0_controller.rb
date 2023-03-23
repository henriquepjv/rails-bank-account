module Api
  # Used at Auth0 Actions to include a user id in the JWT
  class Auth0Controller < ApplicationController
    def index
      # params[:user]
      user = User.find_by(auth: params[:sub])

      render plain: user&.id || false, layout: false
    end
  end
end
