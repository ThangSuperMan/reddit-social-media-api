module Api
  module V1
    class PostsController < Common::BaseController
      before_action :doorkeeper_authorize!, except: [:index]

      include S3

      def index
        posts = Post.all

        json_response(
          message: 'Fetch all posts successfully',
          metadata: posts,
          status: :ok
        )
      end

      def create
        current_user.posts.create(post_params)
        post = Post.last
        PostImage.create(
          media_url: "http://#{ENV['AWS_S3_BUCKET']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{upload_media}",
          media_type: 'image',
          post: 
        )

        json_response(
          message: 'Created post successfully',
          metadata: post,
          status: :created
        )
      end

      private

      def upload_media
        media_file = params[:post][:media]
        s3_upload(media_file)
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end
