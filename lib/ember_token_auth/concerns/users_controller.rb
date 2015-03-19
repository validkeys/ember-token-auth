module EmberTokenAuth
  module UsersController
    extend ActiveSupport::Concern

    included do
      skip_before_filter :authenticate!, only: [:create]
    end


    def create
      unless respond_to?(:user_params)
        return render json: {err: "Please create a user_params property on your users controller"}, status: 500
      end
      @user = User.authenticate(params[:user][:email], params[:user][:password])
      if @user.nil?
        @user = User.new(user_params)
        # @user.password = params[:user][:password]
        unless @user.save
          return render json: {errors: @user.errors.full_messages}, status: 422
        end
      end
      
      render json: @user, status: 200
    end

  end
end