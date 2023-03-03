class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :body
      t.datetime :expiration
    
      t.timestamps
    end

    add_reference :tokens, :verification
    add_index :tokens, :body
  end
end
