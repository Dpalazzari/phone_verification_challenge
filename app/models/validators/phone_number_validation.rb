class Validators::PhoneNumberValidation < ActiveModel::Validator
  def validate(record)
    if record.number
      # First, clear out the extra characters in the number
      num = record.number
      record.update_attribute(:number, num.gsub(/[^\d]/, ''))
      # Must be a ten digit number
      record.errors.add :base, "Invalid length." unless record.number.length == 10
      # This application is not accepting country codes and phone numbers should not start with 1
      record.errors.add :base, "Invalid country code." if record.number[0].eql?('1')
    else
      record.errors.add :base, "Number cannot be blank."
    end
  end
end