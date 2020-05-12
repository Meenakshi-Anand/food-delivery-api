class RemoveRestaurantFromFoodItem < ActiveRecord::Migration[5.2]
  def change
     remove_reference  :food_items,:restaurant, index: true
  end
end
