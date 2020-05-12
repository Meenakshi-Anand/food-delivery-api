require 'rails_helper'

RSpec.describe Address, type: :model do

  describe "full_street_address" do
    before do
      @consumer = Consumer.create!()
      @user = User.create!({
        name: "testuser1",
        email: "test123@codeanand.com",
        password: "testing",
        contact_no: 4159102486,
        entity_type: "Consumer",
        entity_id: @consumer.id})
        
      @address = Address.create!({
        line1: "778, Praderia Cir",
        city: "Fremont",
        state: "CA",
        country: "USA",
        zipcode: 94539,
        user_id: @user.id
        })
    end
    it "should return full address" do
        address = @address.full_street_address
        expect(address).to eq("778, Praderia Cir, 94539, Fremont, USA")
    end
  end

  describe "distance_from" do
    before do
      @restaurant = Restaurant.create!()
      @user1 = User.create!({
        name: "testuser1",
        email: "test1@codeanand.com",
        password: "testing",
        contact_no: 4159102486,
        entity_type: "Restaurant",
        entity_id: @restaurant.id})
      @address1 = Address.create!({
        line1: "778, Praderia Cir",
        city: "Fremont",
        state: "CA",
        country: "USA",
        zipcode: 94539,
        user_id: @user1.id
        })
      AddressWorker.new.perform(@address1.id)
      @address1 = Address.last
      @consumer = Consumer.create!()
      @user2 = User.create!({
        name: "testuser1",
        email: "test12453@codeanand.com",
        password: "testing",
        contact_no: 4159102486,
        entity_type: "Consumer",
        entity_id: @consumer.id})
      @address2 = Address.create!({
        line1: "790, Praderia Cir",
        city: "Fremont",
        state: "CA",
        country: "USA",
        zipcode: 94539,
        user_id: @user2.id
        })
      AddressWorker.new.perform(@address2.id)
    end

    it "should return " do
      distance = @consumer.address.distance_from(@restaurant.address)
      expect(distance.round(3)).to eq(0.018)
    end
  end



end
