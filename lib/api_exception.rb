module ApiException
  EXCEPTIONS = {
    # 400
    'ActiveRecord::RecordInvalid' => { status: 400, message: 'Invalid request' },
    'BadRequest' => { status: 400, message: 'Bad request' },

    # 403
    'CanCan::AccessDenied' => { status: 403, message: 'Access denied' },

    # 404
    'ActiveRecord::RecordNotFound' => { status: 404, message: 'Cannot find record' },
  }.freeze

  class BaseError < StandardError
    attr_reader :status_code, :error_code, :message

    def initialize(msg = nil)
      @message = msg
    end
  end

  module Handler
    def self.included(base)
      base.class_eval do
        EXCEPTIONS.each do |exception_name, context|
          unless ApiException.const_defined?(exception_name)
            ApiException.const_set(exception_name, Class.new(ApiException::BaseError))
            exception_name = "ApiException::#{exception_name}"
          end

          rescue_from exception_name do |exception|
            render json: {
              message: context[:message],
              detail: exception.message
            }.compact,
            status: context[:status]
          end
        end
      end

      def doorkeeper_unauthorized_render_options(error: nil)
        {
          json: {
            message: 'Unauthorized',
            detail: error.try(:description) || 'Access token is invalid or has expired'
          }
        }
      end
    end
  end
end
