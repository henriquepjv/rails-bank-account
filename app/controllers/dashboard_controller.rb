# frozen_string_literal: true

class DashboardController < ApplicationController
  include Secured

  def show
    @user = session[:user_info]
  end
end
