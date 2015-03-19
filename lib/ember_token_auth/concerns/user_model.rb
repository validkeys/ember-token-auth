module EmberTokenAuth
  module UserModel
    extend ActiveSupport::Concern

    included do
      has_secure_password

      validates_presence_of :email
      validates_uniqueness_of :email
    end

    def jwt_params
      self.slice(:id, :email, :created_at)
    end

    module ClassMethods
      # class method to authenticate the user
      # User.authenticate(params[:email], params[:password])
      def authenticate(email, password)
        user = find_by(email: email)
        if user && user.authenticate(password)
          user
        else
          nil
        end
      end
    end
  end
end