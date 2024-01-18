module Api
  module V1
    class UsersController < Common::BaseController
      before_action :doorkeeper_authorize!, except: %i[create]

      def create
        user = User.new(email: user_params[:email], password: user_params[:password])
        client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
        render json: { error: 'Invalid client ID' }, status: :forbidden unless client_app

        if user.save
          access_token = Doorkeeper::AccessToken.create!(
            resource_owner_id: user.id,
            application_id: client_app.id,
            refresh_token: generate_refresh_token,
            expires_in: Doorkeeper.configuration.access_token_expires_in
          )

          render json: {
            user: {
              id: user.id,
              email: user.email,
              access_token: access_token.token,
              token_type: 'bearer',
              expires_in: access_token.expires_in,
              refresh_token: access_token.refresh_token,
              created_at: access_token.created_at.to_time.to_i
            }
          }
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def generate_refresh_token
        loop do
          token = SecureRandom.hex(32)
          is_token_exists_in_database = Doorkeeper::AccessToken.exists?(refresh_token: token)
          break token unless is_token_exists_in_database
        end
      end
    end
  end
end
