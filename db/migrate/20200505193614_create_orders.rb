class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :cart
      t.integer :status, null:false, default:0 
    end
  end
end
