module OauthHelpers
  def oauth_sign_in(user)
    post oauth_token_path, params: {
      grant_type: 'password',
      email: user.email,
      password: user.password,
      client_id: ENV['MOBILE_CLIENT_ID'],
      client_secret: ENV['MOBILE_CLIENT_SECRET']
    }
  end

  def oauth_request_new_access_token(refresh_token)
    post oauth_token_path, params: {
      grant_type: 'refresh_token',
      refresh_token: refresh_token,
      client_id: ENV['MOBILE_CLIENT_ID'],
      client_secret: ENV['MOBILE_CLIENT_SECRET']
    }
  end
end
