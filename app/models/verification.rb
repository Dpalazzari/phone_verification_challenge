class Verification < ApplicationRecord
  include TransactionMethods
  before_save :set_expiration
  before_create :set_expiration

  belongs_to :verificationable, polymorphic: true
  has_many :tokens, dependent: :destroy
  validates :verificationable, presence: true

  def verify_confirmed
    self.verified = true
    self.save
  end
end