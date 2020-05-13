require 'json'
require 'rails_helper'

RSpec.describe AddressWorker, type: :model do
  describe "#perform" do
    it "should save lat long for address when given id" do
      @consumer = Consumer.create!()
      @user = User.create!({
        name: "testuser1",
        email: "test123@codeanand.com",
        password: "testing",
        contact_no: 4159102486,
        entity_type: "Consumer",
        entity_id: @consumer.id})

      @address = Address.create!({
        line1: "8, Praderia Cir",
        city: "Fremont",
        state: "CA",
        country: "USA",
        zipcode: 94539,
        user_id: @user.id
        })

      Response = Struct.new(:body)
      obj = Response.new(JSON.generate(
        {:results=>[{:geometry=>{:location=>{:lat=>37.89685, :lng=>-127.9897}}}]}))

      allow(Net::HTTP).to receive(:get_response) obj }

      AddressWorker.new.perform(@address.id)
      @address.reload
      expect(@address.latitude).to eq(37.89685)
      expect(@address.longitude).to eq(-127.9897)
    end
  end
end
