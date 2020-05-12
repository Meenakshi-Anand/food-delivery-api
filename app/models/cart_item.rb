class CartItem < ApplicationRecord
  validates :quantity, presence:true
  belongs_to :food_item
  belongs_to :cart
end
