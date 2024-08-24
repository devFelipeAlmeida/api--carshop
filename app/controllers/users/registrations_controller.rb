class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :password, :admin])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :password, :admin])
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up successfully." },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end