class AuthenticationController < ApplicationController
  def callback
    redirect_host = request.protocol + request.host_with_port
    access = oauth2_client.auth_code.get_token(params[:code], redirect_uri: "#{redirect_host}/oauth2/callback")

    binding.break
    identity = decode_jwt(access["id_token"], jwks)
    access_token = decode_jwt(access.token, jwks)

    #workspaces = JSON.parse(access.get("https://api.console.iugu.test:443/workspaces").body)
    #workspaces = JSON.parse(access.get("https://api.console.iugu.com/workspaces").body)

    #session[:workspace_id] = workspaces["current"]
    #session[:workspace_name] = workspaces["workspaces"].select { |d| d["id"] == workspaces["current"] }.first["name"]
    session[:access_token] = access.token
    session[:access_token_jwt] = access_token
    session[:identity] = identity

    redirect_to dashboard_url
  rescue JWT::VerificationError, OAuth2::Error, JWT::DecodeError => e
    render plain: "Bad credentials"
  end

  #def logout
  #  reset_session
  #  render plain: "Goodbye"
  #end

  private

  def oauth2_client
    client = OAuth2::Client.new(
      #'6ytGxOU0hwx9HsRAK2xja0',
      #'2e4784bd3c003cf4a908243af06df41eed9dcdfa1c53ecf7d32d2ce6292b5a2cef47807f',
      #site: 'https://identity.iugu.com',
      '4XOIsWRimgMDqwyF4YoChZ',
      '0a65a647f4b0a1e203fce45790995a1db4ad41155831496d82324bc978e0303a4e78a1ff',
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
                 aud:        ["Iugu.Platform.4XOIsWRimgMDqwyF4YoChZ"],
                 verify_aud: true,
                 jwks:       { keys: jwks_hash[:keys] }
               })
  end
end
