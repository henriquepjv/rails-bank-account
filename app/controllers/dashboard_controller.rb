# frozen_string_literal: true

class DashboardController < ApplicationController
  include Secured

  def show
    @user_info = session[:user_info]
    @user = User.find_by(auth: session.dig('user_info', 'sub'))
    @bank_accounts = @user.bank_accounts
  end
end
