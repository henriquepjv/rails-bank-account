class AuthenticationController < ApplicationController
  def callback
    redirect_host = request.protocol + request.host_with_port
    access = oauth2_client.auth_code.get_token(params[:code], redirect_uri: "#{redirect_host}/oauth2/callback")

    identity = decode_jwt(access["id_token"], jwks)
    access_token = decode_jwt(access.token, jwks)

    workspaces = JSON.parse(access.get("https://api.console.iugu.test/workspaces?audience=Iugu.Platform.0mWyr4AfdWVp22yzQ7jiL9").body)

    session[:user_id] = access_token.first["sub"].gsub("user:", "")
    session[:workspace_id] = workspaces["current"]
    session[:workspace_name] = workspaces["workspaces"].select { |d| d["id"] == workspaces["current"] }.first["name"]
    session[:access_token] = access.token
    session[:access_token_jwt] = access_token
    session[:identity] = identity

    redirect_to dashboard_url
  rescue JWT::VerificationError, OAuth2::Error, JWT::DecodeError => e
    render plain: "Bad credentials"
  end

  def logout
    reset_session
    redirect_to "/"
  end

  private

  def oauth2_client
    client = OAuth2::Client.new(
      #'6ytGxOU0hwx9HsRAK2xja0',
      #'2e4784bd3c003cf4a908243af06df41eed9dcdfa1c53ecf7d32d2ce6292b5a2cef47807f',
      #site: 'https://identity.iugu.com',
      '2fTTzy4v4nrfSM0Myfzzrf',
      '1ebed5ace731b55464937c04a84ce776ff394463ce4e8231eda4a1aa9b03d281cc524d20',
      site: 'https://identity.iugu.test',
      redirect_uri: 'http://localhost:3000/oauth2/callback',
      authorize_url: '/authorize',
      token_url: '/token'
    )
  end

  def get_jwks
    #jwks_uri = URI("https://identity.iugu.com/.well-known/jwks.json")
    jwks_uri = URI("https://identity.iugu.test/.well-known/jwks.json")
    Net::HTTP.get_response jwks_uri
  end

  def jwks
    jwks_response = get_jwks

    unless jwks_response.is_a? Net::HTTPSuccess
      error = Error.new(message: 'Unable to verify credentials', status: :internal_server_error)
      return Response.new(nil, error)
    end

    jwks_hash = JSON.parse(jwks_response.body).deep_symbolize_keys
  end

  def decode_jwt(token, jwks_hash)
    JWT.decode(token, nil, true, {
                 algorithm:  "RS256",
                 #iss:        "https://identity.iugu.com/",
                 iss:        "https://identity.iugu.test/",
                 verify_iss: true,
                 #aud:        ["Iugu.Platform.6ytGxOU0hwx9HsRAK2xja0"],
                 aud:        ["Iugu.Platform.2fTTzy4v4nrfSM0Myfzzrf"],
                 verify_aud: true,
                 jwks:       { keys: jwks_hash[:keys] }
               })
  end
end
