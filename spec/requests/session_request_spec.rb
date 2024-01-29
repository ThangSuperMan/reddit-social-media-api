require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }

  describe 'POST /oauth/token' do
    before { oauth_sign_in(user) }

    context 'valid credentials' do
      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
        expect(json_body).to include(response_format(latest_access_token))
      end

      it 'succeeds in creating a new access_token based on refresh_token' do
        oauth_request_new_access_token(latest_access_token.refresh_token)

        expect(response).to have_http_status(:success)
        expect(json_body).to include(response_format(latest_access_token))
      end

      it 'makes access_token expire' do
        oauth_logout(latest_access_token.token)

        expect(response).to have_http_status(:success)
        expect(latest_access_token.revoked_at).to_not be_nil
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
