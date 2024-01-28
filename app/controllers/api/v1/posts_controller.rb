module Api
  module V1
    class PostsController < Common::BaseController
      before_action :doorkeeper_authorize!, except: [:index, :show]

      include S3

      def index
        posts = Post.all.includes(:post_images).map do |post|
          {
            post: post,
            images: post_images(post.post_images)
          }
        end

        json_response(
          message: 'Fetch all posts successfully',
          metadata: posts,
          status: :ok
        )
      end

      def show
        post = Post.find(params[:id])

        json_response(
          message: 'Fetch a post successfully',
          metadata: {
            post: post,
            images: post_images(post.post_images)
          },
          status: :ok
        )
      end

      def create
        current_user.posts.create(post_params)

        post = Post.last
        PostImage.create(
          media_url: "http://#{ENV['AWS_S3_BUCKET']}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{upload_media}",
          media_type: 'image',
          post: post
        )

        json_response(
          message: 'Created post successfully',
          metadata: {
            post: post,
            images: post_images(post.post_images)
          },
          status: :created
        )
      end

      private

      def post_images(images)
        images.map { |image| { media_url: image.media_url, media_type: image.media_type } }
      end

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
