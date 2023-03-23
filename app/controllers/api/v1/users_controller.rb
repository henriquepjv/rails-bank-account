module Api::V1
  class UsersController < ApplicationController
    # skips CSRF protection, add to api controller
    skip_before_action :verify_authenticity_token
    def create
      user = User.create(email: received_params[:email])

      render json: {
        message: "Created User with #{received_params[:email]}",
        id: user.id
      }, status: :created
    end

    private

    def received_params
      params.permit(:email)
    end
  end
end
