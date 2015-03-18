Rails.application.routes.draw do
  post "/sessions/token" => "ember_token_auth/sessions#token"
  post "/sessions/token_refresh" => "ember_token_auth/sessions#token_refresh"
end
