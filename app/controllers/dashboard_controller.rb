# frozen_string_literal: true

class DashboardController < ApplicationController
  include Secured

  def show
    @workspace_id = session[:workspace_id]
    @workspace_name = session[:workspace_name]
    @access_token = session[:access_token]
    @access_token_jwt = session[:access_token_jwt]
  end
end
