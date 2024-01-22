require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /oauth/token' do
    let(:user) { create(:user) }

    context 'valid credentials' do
      it 'returns a successful response' do
        oauth_sign_in(user)

        access_token = latest_access_token
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json_body).to include(response_format(access_token))
      end

      it 'returns a access_token based on refresh_token' do
        oauth_sign_in(user)

        access_token = Doorkeeper::AccessToken.last
        oauth_request_new_access_token(access_token.refresh_token)
        access_token = latest_access_token
        json_body = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(json_body).to include(response_format(access_token))
      end
    end

    private

    def latest_access_token
      Doorkeeper::AccessToken.last
    end

    def response_format(access_token)
      {
        'access_token' => access_token.token,
        'token_type' => 'Bearer',
        'expires_in' => access_token.expires_in,
        'refresh_token' => access_token.refresh_token,
        'created_at' => access_token.created_at.to_time.to_i
      }
    end
  end
end
