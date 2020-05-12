class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :consumer
      t.belongs_to :restaurant
      t.integer :order_status, null:false, default:0
      t.timestamps
    end
  end
end
