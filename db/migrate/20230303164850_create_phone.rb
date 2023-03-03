class CreatePhone < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.string :number
      
      t.timestamps
    end

    add_index :phones, :number
  end
end
