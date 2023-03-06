require 'rails_helper'

RSpec.describe Phone, type: :model do
  context 'Validations' do
    it "is valid with valid number" do
      expect(Phone.new(number: '7186520848')).to be_valid
    end
      
    it "is not valid without a number" do
      expect(Phone.new).to_not be_valid
    end 
  
    it "is not valid with too short number" do
      expect(Phone.new(number: '718652084' )).to_not be_valid
    end

    it "is not valid with too long number" do
      expect(Phone.new(number: '71865208444' )).to_not be_valid
    end

    it 'removes special characters and saves only digits' do
      phone = Phone.create(number: '(303)-ab719-2233')
      expect(phone.number).to eq("3037192233")
    end
  end

  context 'Associations' do
    it { should have_many(:verifications).class_name('Verification')}
  end
end
