class CreateAddresWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :address_workers do |t|

      t.timestamps
    end
  end
end
