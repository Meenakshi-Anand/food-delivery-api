class FoodItem < ApplicationRecord
  validates :name, :price, presence:true
  has_many :cart_items
  has_and_belongs_to_many :menus
end
