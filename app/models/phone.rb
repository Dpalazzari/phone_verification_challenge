class Phone < ApplicationRecord
  validates_with Validators::PhoneNumberValidation
  has_many :verifications, as: :verificationable, dependent: :destroy
  
  def send_verification_sms
    # When an SMS is sent, two things should be created:
    # 1) one verification record with
    # 2) an active token record
    # Destroy all existing verification records
    verifications.destroy_all
    verification = verifications.create
    token = verification.tokens.create
    message = "DO NOT REPLY. Your authorization code is #{token.body}. This code expires in #{Trait.token_expiration_days} day(s)."
    # Set the API request params
    params = {
      client: ENV['client'],
      authorization_code: ENV['authorization_code'],
      phone_number: number,
      message: message
    }
    # Build the URI, attach the parameters and make a GET request
    uri = URI(ENV['url'])
    uri.query = URI.encode_www_form(params)
    # Return the response
    Net::HTTP.get_response(uri)
  end

  def verify_view
    {
      phone: attributes,
      verification: verifications.last.attributes
    }
  end

  def already_verified?
    verification = verifications.last
    return false unless verification
    verification.verified? && !verification.expired?
  end
end