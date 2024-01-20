# module Api
#   module V1
#     class PostsController < Common::BaseController
#       def index
#         posts = Post.all

#         render json: {
#           message: 'Fetch all posts successfully',
#           metadata: posts
#         }, status: :created
#       end

#       def create
#         render json: {
#           message: 'Created post successfully',
#           metadata: data
#         }, status: :created
#       end

#       private

#       def post_params
#         params.require(:post).permit(:title, :body)
#       end
#     end
#   end
# end
