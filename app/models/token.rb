class Token < ApplicationRecord
  include TransactionMethods
  belongs_to :verification
  # No validations on this model because the transaction methods cover the presence and uniqueness of the token body
  before_save :generate_uuid, :set_expiration
  before_create :generate_uuid, :set_expiration

end
