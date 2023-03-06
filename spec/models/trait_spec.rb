require 'rails_helper'

RSpec.describe Trait, type: :model do
  context 'Class Methods' do
    context '#token_expiration_days' do
      it 'returns token expiration in days' do
        days = Trait.token_expiration_days
        expect(days.class).to eq(Integer)
        expect(days).to eq(1)
      end
    end

    context '#verification_expiration_days' do
      it 'returns verification expiration in days' do
        days = Trait.verification_expiration_days
        expect(days.class).to eq(Integer)
        expect(days).to eq(365)
      end
    end
  end
end
