require 'rails_helper'

module ApiHelper
  def authenticated_header(request, user)
    token = Auth.issue({ user: user.id })
    request.headers.merge!('Authorization': "Bearer #{token}")
  end
end


RSpec.describe Api::ReviewsController, type: :controller do
  include ApiHelper
  describe "POST create" do
    context "with valid attributes" do
      before do
        @consumer_entity = Consumer.create!()
        @consumer = User.create!({
          name: "testuser1",
          email: "test123@codeanand.com",
          password: "testing",
          contact_no: 4159102486,
          entity_type: "Consumer",
          entity_id: @consumer_entity.id})

        @restaurant_entity = Restaurant.create!()
        @restaurant= User.create!({
          name: "testuser2",
          email: "test321@codeanand.com",
          password: "testing",
          contact_no: 4159102486,
          entity_type: "Restaurant",
          entity_id: @restaurant_entity.id})

        @food_item = FoodItem.create({
          name: "Fries",
          price: 5,
          })

        @cart = Cart.create!({
          consumer_id: @consumer_entity.id,
          restaurant_id: @restaurant_entity.id,
          order_status:0
          })

        @cart_item = CartItem.create!({
          cart_id: @cart.id,
          food_item_id: @food_item.id,
          quantity: 2
          })

        @order = Order.create!({
          status: 0,
          cart_id: @cart.id,
          consumer_id: @consumer_entity.id,
          restaurant_id: @restaurant_entity.id
          })

        authenticated_header(request,@consumer)

        @review = {
          description: "Great Experience",
          order_id: @order.id,
          id: @restaurant_entity.id,
          cart_id: @cart.id
        }

        post :create,
        params: @review
      end
      it "should be successful" do
       expect(response).to be_successful
      end
    end
  end
end
