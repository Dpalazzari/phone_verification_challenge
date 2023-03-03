class CreateTraits < ActiveRecord::Migration[7.0]
  def up
    create_table :traits do |t|
      t.string :slug
      t.integer :value
      t.timestamps
    end

    add_index :traits, :slug

    # Initialize two trait records for setting token and verificaiton expiration dates
    Trait.create(slug: 'token_expiration_days', value: 1)
    Trait.create(slug: 'verification_expiration_days', value: 365)
    Trait.create(slug: 'verification_code_length', value: 4)

  end

  def down
    drop_table :traits
  end
end
