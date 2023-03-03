module Token::TransactionMethods
  def generate_uuid
    # exit the process if there is already a populated body
    return if body
    code_length = Trait.verification_code_length
    # Create a UUID
    uuid = SecureRandom.hex(code_length)
    # Check if a token exists by this uuid
    token = Token.find_by(body: uuid)
    # Loop until a unique identifier is found
    until token.nil?
      uuid = SecureRandom.hex(code_length)
      token = Token.find_by(body: uuid)
    end
    self.body = uuid
  end

  def set_expiration
    # return if the expiration is already set
    return if expiration
    # Query the expiration days from the traits table
    token_expiration = Trait.token_expiration_days
    # Set Expiration
    self.expiration = DateTime.now + token_expiration.days
  end
end
