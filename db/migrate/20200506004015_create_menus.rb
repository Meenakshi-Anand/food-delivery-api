class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :meal_category, null:false, default:0
      t.belongs_to :restaurant
    end
  end
end
