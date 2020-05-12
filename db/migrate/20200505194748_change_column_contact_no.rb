class ChangeColumnContactNo < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :contact_no, :bigint
  end
end
