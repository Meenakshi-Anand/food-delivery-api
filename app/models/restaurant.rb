class Restaurant < ApplicationRecord
  has_one :user , as: :entity
  has_many :working_hours
  has_many :menus
  has_many :carts
  has_many :orders
  has_one :address, through: :user
  
  def get_menu_of_category(category)
    self.menus.select{|m| m.meal_category == category}.first
  end
  def get_menu_list(category)
    self.get_menu_of_category(category).food_items
  end
end
