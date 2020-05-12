class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_no, :integer
  end
end
