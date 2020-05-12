class Consumer < ApplicationRecord
  has_one :user , as: :entity
  has_many :orders
  has_one :address, through: :user
end
