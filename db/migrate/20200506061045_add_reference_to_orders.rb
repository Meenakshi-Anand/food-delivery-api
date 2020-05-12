class AddReferenceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders , :restaurant, index:true
  end
end
