module Common
  class BaseController < AuthController
    include ApiException::Handler
  end
end
