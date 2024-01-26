module Common
  class BaseController < AuthController
    include ApiException::Handler

    def json_response(message:, metadata:, status:)
      render json: {
        message: message,
        metadata: metadata
      }, status: status
    end
  end
end
