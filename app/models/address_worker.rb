require 'net/http'

class AddressWorker < ApplicationRecord
  include Sidekiq::Worker
  # sidekiq_options retry: false

  def perform(address_id)
    address = Address.find(address_id)
    uri = URI('https://maps.googleapis.com/maps/api/geocode/json?address='+address.full_street_address+'&key='+ENV["API_KEY"])
    response = Net::HTTP.get_response(uri)
    response = JSON.parse(response.body)
    address.latitude = response["results"][0]["geometry"]["location"]["lat"]
    address.longitude = response["results"][0]["geometry"]["location"]["lng"]
    address.save!
  end

end
