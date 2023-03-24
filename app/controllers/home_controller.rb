class HomeController < ApplicationController
  def show
    @user = session[:user_info]
  end
end
