class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :line1, null:false
      t.string :line2
      t.string :city, null:false
      t.string :state, null:false
      t.string :country, null:false
      t.integer :zipcode, null:false
      t.belongs_to :user
    end
  end
end
