require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }

  before do
    oauth_sign_in(user)

    file_name = "#{SecureRandom.hex(8)}.png"
    allow_any_instance_of(Api::V1::PostsController).to receive(:upload_media).and_return(file_name)
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        post: {
          title: 'Post title',
          body: 'Post body'
        }
      }
    end

    it 'succeeds in creating a post with an associated image' do
      access_token = Doorkeeper::AccessToken.last.token

      expect do
        post api_v1_posts_path, params: valid_params, headers: { 'Authorization' => "Bearer #{access_token}" }
      end.to change(Post, :count).by(1).and change(PostImage, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
