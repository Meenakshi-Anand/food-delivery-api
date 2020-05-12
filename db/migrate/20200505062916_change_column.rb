class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :restaurants, :delivery_range, :decimal, :null => false
  end
end
