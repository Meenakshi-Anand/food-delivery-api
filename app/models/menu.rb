class Menu < ApplicationRecord
  validates :meal_category , presence:true
  enum meal_category: ['breakfast','lunch','dinner']
  belongs_to :restaurant
  has_and_belongs_to_many :food_items, dependant: :delete_all

end
