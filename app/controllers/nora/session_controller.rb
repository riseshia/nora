require_dependency 'nora/application_controller'

module Nora
  class SessionController < ApplicationController
    skip_before_action :require_sign_in, only: %i(new create)
    def new; end

    def create
      auth = request.env['omniauth.auth']
      user = Nora::User.sign_in!(auth)
      session[:user_id] = user.id
      redirect_to root_path
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end
  end
end
