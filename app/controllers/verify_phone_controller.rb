class VerifyPhoneController < ApplicationController
  skip_before_action :verify_authenticity_token

  def verify
    # This controller should be able to send multiple verifications to new or existing phone numbers
    phone = Phone.find_or_initialize_by(phone_params)
    if phone.save
      # if the phone is already verified, and the verification is expired, there is no need to go any further
      return already_verified if phone.already_verified?
      response = phone.send_verification_sms
      if response.is_a?(Net::HTTPSuccess)
        render json: { phone: phone.verify_view, message: 'verification sms sent.' }, status: 200
      else
        # The twilio API has a couple error messages it can return if parameters are missing or incorrect
        render json: {message: 'Error sending SMS.', error: response.body}
      end
    else
      # If any of the phone models validations go wrong, it will show here
      render json: { error_message: phone.errors.full_messages }
    end
  rescue StandardError => error
    render json: { message: 'There was an unexpected error.', error: error.message }, status: 500
  end

  private

  def phone_params
    params.require(:phone).permit(:number)
  end

  def already_verified
    render json: { message: 'Phone already verified' }, status: 400
  end
end