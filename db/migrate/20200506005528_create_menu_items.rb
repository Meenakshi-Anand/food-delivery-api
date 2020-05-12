class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :food_items_menus do |t|
      t.belongs_to :menu
      t.belongs_to :food_item
      t.timestamps
    end
  end
end
