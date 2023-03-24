# frozen_string_literal: true

class Auth0Controller < ApplicationController
  def callback
    # OmniAuth stores the information returned from Auth0 and the IdP in request.env['omniauth.auth'].
    # In this code, you will pull the raw_info supplied from the id_token and assign it to the session.
    # Refer to https://github.com/auth0/omniauth-auth0#authentication-hash for complete information on 'omniauth.auth' contents.
    auth_info = request.env["omniauth.auth"]
    # puts auth_info["credentials"]["id_token"]
    session[:id_token] = auth_info["credentials"]["id_token"]
    session[:token] = auth_info["credentials"]["token"]
    session[:user_info] = auth_info["extra"]["raw_info"]

    user_auth = auth_info["extra"]["raw_info"]["sub"]
    user = User.find_by(auth: user_auth)
    unless user
      user = User.new
      user.auth = user_auth
      user.name = auth_info["extra"]["raw_info"]["name"]
      # user.profile = auth_info["extra"]["raw_info"]["picture"]
      user.email = auth_info["extra"]["raw_info"]["email"]
      user.save
    end

    session[:user_id] = user.id

    # User.find(auth: )
    # puts session[:userinfo]

    # Redirect to the URL you want after successful auth
    redirect_to dashboard_path
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params["message"]
  end

  def logout
    reset_session
    redirect_to logout_url, allow_other_host: true
  end

  private

  def logout_url
    request_params = {
      returnTo:  root_url,
      client_id: Rails.application.credentials.auth0[:client_id]
    }

    URI::HTTPS.build(
      host:  Rails.application.credentials.auth0[:domain],
      path:  "/v2/logout",
      query: request_params.to_query
    ).to_s
  end
end
