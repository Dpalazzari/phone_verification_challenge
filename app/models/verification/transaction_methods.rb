module Verification::TransactionMethods
  def set_expiration
    # return if the expiration is already set
    return if expiration
    # Query the verification expiration num of days from traits table
    verification_expiration = Trait.verification_expiration_days
    self.expiration = DateTime.now + verification_expiration.days
  end
end