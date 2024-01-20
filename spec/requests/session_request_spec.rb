require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /oauth/token' do
    let(:user) { create(:user) }

    context 'valid credentials' do
      it 'returns a successful response' do
        user
        post oauth_token_path, params: {
          grant_type: 'password',
          email: user.email,
          password: user.password,
          client_id: ENV['MOBILE_CLIENT_ID'],
          client_secret: ENV['MOBILE_CLIENT_SECRET']
        }

        json_body = JSON.parse(response.body)
        access_token = Doorkeeper::AccessToken.last
        expected_response_data = {
          'access_token' => access_token.token,
          'token_type' => 'Bearer',
          'expires_in' => access_token.expires_in,
          'refresh_token' => access_token.refresh_token,
          'created_at' => access_token.created_at.to_time.to_i
        }

        expect(response).to have_http_status(:success)
        expect(json_body).to include(expected_response_data)
      end
    end

    context 'invalid credentials' do
    end
  end
end
