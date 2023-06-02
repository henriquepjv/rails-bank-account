class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    binding.break
    user_info = request.env['omniauth.auth']
    raise user_info # Your own session management should be placed here.
  end
end
