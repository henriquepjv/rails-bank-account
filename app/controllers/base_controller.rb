require 'oauth2'

class BaseController < ApplicationController
  before_action :authenticated?
  before_action :expose_auth_variables
  rescue_from OAuth2::Error, with: :handle_oauth2_errors

  private

  def handle_oauth2_errors(exception)
    if exception.code == "Expired JWT"
      redirect_user_to_auth 
      return false
    end
    raise exception
  end

  def authenticated?
    return if current_user

    redirect_user_to_auth
  end

  def redirect_user_to_auth
    redirect_host = request.protocol + request.host_with_port 
    redirect_to oauth2_client.auth_code.authorize_url(redirect_uri: "#{redirect_host}/oauth2/callback"), allow_other_host: true
  end

  def expose_auth_variables
    @current_user = current_user
    @current_workspace = current_workspace
    @current_workspace_name = current_workspace_name
  end

  def oauth2_client
    client = OAuth2::Client.new(
      '6UC4iFYbGgkBc0UxSa9aLt',
      'f6e20107236b556cb8d108db842be6247da50c4d520cef3434df16b51aa288e63420d189',
      site: 'https://identity.iugu.com',
      authorize_url: '/authorize',
      token_url: '/token'
    )
  end

  def current_user
    return nil unless session[:identity]

    sub = session[:identity][0]["sub"]
    splitted_sub = sub.split(":")
    uuid_type = "user"
    uuid = splitted_sub.last
    uuid_type = "app" if (splitted_sub.first == "app")

    user_id = UuidTools.unshort(uuid)

    return user_id
  end

  def current_user_token
    return nil unless session[:access_token]

    session[:access_token_jwt]
  end

  def current_workspace
    return nil unless session[:workspace_id]

    UuidTools.unshort(session[:workspace_id])
  end

  def current_workspace_name
    return nil unless session[:workspace_name]

    session[:workspace_name]
  end
end
