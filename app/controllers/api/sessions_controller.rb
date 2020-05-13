class Api::SessionsController < ApplicationController
  skip_before_action :authenticate

    def create
      @user = User.find_by(email: params[:email])

      if @user && @user.authenticate(params[:password])
         @jwt = Auth.issue({user: @user.id})
        render json: [user: @user, jwt: @jwt ]
      else
        render json: ["Invalid Username or Password"], status: 422
      end
    end
end
