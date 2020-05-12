class WorkingHour < ApplicationRecord
  validates :day, :start_time, :end_time, :status, presence:true
  enum status: ['working','not_working']
  belongs_to :restaurant
end
