module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticated?
    before_action :expose_auth_variables
    #before_action :authorized?
  end

  def authenticated?
    return if current_user

    redirect_user_to_auth
  end

  def expose_auth_variables
    @current_user = current_user
    @current_workspace = session[:workspace_id]
    @current_workspace_name = session[:workspace_name]
  end

  def authorized?
    @action = 'create:bank_account'

    uri = URI.parse("https://identity.iugu.test/verify")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = authorization_request_body
    binding.break
    response = http.request(request)

    #request =
      #HttpClient.post(
      #  "https://identity.iugu.test",
      #  "/verify",
      #  body: authorization_request_body,
      #  headers: headers
      #)

    return if request.response == '1'

    redirect_to :root, notice: 'Não autorizado'
  end

  def headers
    {
      Authorization: "Bearer 123"
    }
  end

  def authorization_request_body
    {
      w: @current_workspace,
      p: "user:#{@current_user}",
      a: @action
    }
  end

  def current_user
    return nil unless session[:identity]

    sub = session[:identity][0]["sub"]
    splitted_sub = sub.split(":")
    uuid_type = "user"
    uuid = splitted_sub.last
    uuid_type = "app" if (splitted_sub.first == "app")

    # user_id = UuidTools.unshort(uuid)
    user_id = uuid

    return user_id
  end

  def redirect_user_to_auth
    redirect_host = request.protocol + request.host_with_port
    redirect_to oauth2_client.auth_code.authorize_url(redirect_uri: "#{redirect_host}/oauth2/callback"), allow_other_host: true
  end

  def oauth2_client
    client = OAuth2::Client.new(
      '2fTTzy4v4nrfSM0Myfzzrf',
      '1ebed5ace731b55464937c04a84ce776ff394463ce4e8231eda4a1aa9b03d281cc524d20',
      site: 'https://identity.iugu.test',
      redirect_uri: 'http://localhost:3000/oauth2/callback',
      authorize_url: '/authorize',
      token_url: '/token'
    )
  end
end
