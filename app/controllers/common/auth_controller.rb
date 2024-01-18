module Common
  class AuthController < ApplicationController
    before_action :doorkeeper_authorize!

    private

    def current_use
      @current_user ||= User.find_id(id: doorkeeper_token[:resource_owner_id])
    end
  end
end
