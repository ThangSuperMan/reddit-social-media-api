module UserHelpers
  def user_sign_up(email:, password:)
    post api_v1_users_path, params: {
      email: email,
      password: password,
      client_id: ENV['MOBILE_CLIENT_ID']
    }
  end
end
