class Address < ActiveRecord::Base
  include Distance
  validates :line1, :city, :state, :country, :zipcode, presence: true

  belongs_to :user
  has_many :restaurants, through: :user
  has_many :consumers, through: :user

  def full_street_address
    "#{self.line1}, #{self.zipcode}, #{self.city}, #{self.country}"
  end

  # calculate distance using haversines formula
  def distance_from (address)
    distance_between(self, address)
  end

end
