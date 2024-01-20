require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST create' do
    context 'with invalid user params' do
      it 'returns error status after creating a new user' do
        post api_v1_users_path, params: {
          email: 'thanghandsome@.gmail.com',
          password: 'password123',
          client_id: ENV['MOBILE_CLIENT_ID']
        }

        expect(response).to have_http_status(422)
      end
    end

    context 'with valid user params' do
      it 'returns the user data' do
        post api_v1_users_path, params: {
          email: 'thanghandsome@gmail.com',
          password: 'password123',
          client_id: ENV['MOBILE_CLIENT_ID']
        }
        user = User.last
        access_token = Doorkeeper::AccessToken.last
        json_body = JSON.parse(response.body)
        expected_user_data = {
          'id' => user.id,
          'email' => user.email,
          'access_token' => access_token.token,
          'token_type' => 'bearer',
          'expires_in' => access_token.expires_in,
          'refresh_token' => access_token.refresh_token,
          'created_at' => access_token.created_at.to_time.to_i
        }

        expect(response).to have_http_status(:created)
        expect(json_body['user']).to include(expected_user_data)
      end
    end
  end
end