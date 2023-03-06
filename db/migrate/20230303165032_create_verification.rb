class CreateVerification < ActiveRecord::Migration[7.0]
  def change
    create_table :verifications do |t|
      # In the event that I wanted to have some form of email verification as well, I would use the same table
      t.references :verificationable, polymorphic: true
      t.boolean :verified, default: false
      t.datetime :expiration
      t.timestamps
    end
  end
end
