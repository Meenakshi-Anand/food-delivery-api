class AddReferenceToOrdersConsumers < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders , :consumer, index:true
  end
end
