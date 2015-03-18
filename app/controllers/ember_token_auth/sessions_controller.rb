module EmberTokenAuth
  class SessionsController < ::ApplicationController
    def token
      user = User.authenticate(params[:email], params[:password])
      if user
        set_current_user user
        render json: { token: generate_token(user)}, status: 200
      else
        render json: {errors: ["Unauthorized"]}, status: 401
      end
    end

    def token_refresh
      render json: { token: generate_token(@current_user)}, status: 200
    end

    private

    def generate_token(user)
      # exp = 30.days.from_now.to_i
      exp     = (Time.now + 15).to_i
      payload = { user: user.jwt_params, exp: exp }
      JWT.encode(payload, Rails.configuration.secret_token)
    end
  end
end