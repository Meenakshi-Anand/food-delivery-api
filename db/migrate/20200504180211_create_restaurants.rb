class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.decimal :delivery_range,null:false
    end
  end
end
