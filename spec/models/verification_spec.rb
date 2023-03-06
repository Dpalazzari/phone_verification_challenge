require 'rails_helper'

RSpec.describe Verification, type: :model do
  context 'Validations' do
    it "is valid with verificationable" do
      phone = Phone.new(number: '7186520848')
      expect(Verification.new(verificationable: phone)).to be_valid
    end
      
    it "is not valid without a verificationable" do
      expect(Verification.new).to_not be_valid
    end 
  end

  context 'Associations' do
    it { should belong_to(:verificationable) }
  end

  context 'Transactions' do
    context 'set_expiration' do
      it 'generates an expiration date' do
        phone = Phone.new(number: '7186520848')
        verification = Verification.new(verificationable: phone)
        token = Token.new(verification: verification)
        token.save
        expect(token).to be_valid
        expect(token.expiration).to be_truthy
      end
    end
  end

  context 'Instance Methods' do
    context 'expired?' do
      it 'is expired when the current date is greater than the expiration date' do
        phone = Phone.new(number: '7186520848')
        verification = Verification.new(verificationable: phone)
        verification.save

        verification.update_attribute(:expiration, DateTime.now - 1.days)

        expect(verification.expired?).to be_truthy
      end
    end
  end
end
