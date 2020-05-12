class Order < ApplicationRecord
  validates :status, presence:true
  enum status: ['preparing','out_for_delivery','delivered']
  belongs_to :cart
  belongs_to :consumer
  belongs_to :restaurant
  has_one :review
end
