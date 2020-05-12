class CreateFoodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :food_items do |t|
      t.string :name, null: false , unique:true
      t.integer :price, null:false
      t.string :description
      t.belongs_to :restaurant
    end
    add_index :food_items, :name, unique:true
  end
end
