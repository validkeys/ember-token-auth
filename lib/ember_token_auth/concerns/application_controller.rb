require 'jwt'
module EmberTokenAuth
  module ApplicationController
    extend ActiveSupport::Concern

    included do
      before_filter :check_for_token
      hide_action :decoded_token
      hide_action :set_current_user
      hide_action :current_user
      helper_method :current_user
    end

    def decoded_token
      JWT.decode(http_auth_header, Rails.configuration.secret_token, true, {leeway: 10})    
    end

    def set_current_user(user)
      @current_user = user
    end

    def current_user
      @current_user || nil
    end

    private

    def http_auth_header
      if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      else
        nil
      end
    end

    def set_current_user_from_token(token)
      set_current_user User.find(token[0]["user"]["id"])
    end

    def check_for_token
      return if http_auth_header.nil?
      begin
        set_current_user_from_token(decoded_token)
      rescue JWT::ExpiredSignature
        render json: {error: "JWT Expired"}, status: 401
      rescue JWT::DecodeError
        render json: {error: "JWT Decode Error"}, status: 401
      end
    end

    def authenticate!
      if !current_user
        render json: {errors: ["Unauthorized"]}, status: 401
      end
    end
    
  end
end