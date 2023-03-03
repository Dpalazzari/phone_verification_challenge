class Trait < ApplicationRecord

  def self.token_expiration_days
    # Find the designated expiration data in the db (saving it in the db makes it easy to change on the fly)
    # OR default to 1 (day) if the record can not be found
    find_by_slug(:token_expiration_days).try(:value) || 1
  end

  def self.verification_expiration_days
    # Find the designated expiration data in the db (saving it in the db makes it easy to change on the fly)
    # OR default to 365 (days) if the record can not be found
    find_by_slug(:verification_expiration_days).try(:value) || 365
  end

  def self.verification_code_length
    find_by_slug(:verification_code_length).try(:value) || 4
  end
end
