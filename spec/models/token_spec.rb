require 'rails_helper'

RSpec.describe Token, type: :model do
  context 'Associations' do
    it { should belong_to(:verification).class_name('Verification')}
  end

  context 'Transactions' do
    context 'generate_uuid' do
      it 'generates a short, unique identifier before saving' do
        phone = Phone.new(number: '7186520848')
        verification = Verification.new(verificationable: phone)
        token = Token.new(verification: verification)
        token.save
        expect(token).to be_valid
        expect(token.body).to be_truthy
      end
    end

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
        token = Token.new(verification: verification)
        token.save

        token.update_attribute(:expiration, DateTime.now - 1.days)

        expect(token.expired?).to be_truthy
      end
    end
  end

end
