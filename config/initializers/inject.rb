Rails.application.config.to_prepare do
  ApplicationController.class_eval do
    include EmberTokenAuth::ApplicationController
  end

  User.class_eval do
    include EmberTokenAuth::UserModel
  end

end