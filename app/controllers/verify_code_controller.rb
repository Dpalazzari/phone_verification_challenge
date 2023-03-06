class VerifyCodeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def confirm_verify
    # Find the phone record - use find by so .find does not throw an error
    phone = Phone.find_by(id: params[:phone_id])
    if phone
      # Check if the supplied verification code belongs to a token record associated to the phone
      verification = phone.verifications.last
      token = verification.tokens.find_by(body: params[:verification_code])
      # If the token is found, the phone is verified - update the verification record accordingly
      if token
       verification.verify_confirmed
       render json: { phone: phone.verify_view, message: 'verification code accepted.' }, status: 200
      else
        # Perhaps the user types in the verification code incorrectly?
        render json: { message: 'Supplied verification code not found.' }, status: 404
      end
    else
      # If for some reason the associated phone can not be found
      render json: { message: 'Associated phone not found.' }, status: 404
    end
  rescue StandardError => error
    render json: { message: 'There was an unexpected error.', error: error.message }, status: 500
  end

  private

  def verification_params
    params.require(:phone_id, :verification_code)
  end

end