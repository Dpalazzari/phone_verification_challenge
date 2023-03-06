Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "verify_phone#index"

  post "/api/v1/phone/verify" => "verify_phone#verify"
  post "/api/v1/phone/:phone_id/confirm_verification_code" => "verify_code#confirm_verify"
end
