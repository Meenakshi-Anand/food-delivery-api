class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :name, :password_digest,:contact_no, presence: true
  # validates :password, length: {minimum: 6}, presence:true
  belongs_to :entity , polymorphic:true
  has_one :address

  def get_delivering_restaurants
    result = []
    restaurants = Restaurant.all
    restaurants.each do |restaurant|
      distance = self.address.distance_from(restaurant.address)
      if restaurant.delivery_range && distance <= restaurant.delivery_range
        result << restaurant.address
      end
    end
    result
  end



end
