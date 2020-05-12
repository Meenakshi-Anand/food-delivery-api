require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe "POST create" do

    context "with valid attributes" do
      before do
        @count = User.count
        @user = {name:"testuser",email:"test123@codeanand.com",password:"testing",contact_no:4159102486,entity_type:"Restaurant",
               line1:"778, Praderia Cir",city:"Fremont",state:"CA",country:"USA",zipcode:94539}
        post :create,
        params: @user
      end
      it "should be successful" do
       expect(response).to be_successful
      end
      it "creates a new record in the database" do
        new_user = User.last
        expect(User.count).to eq(@count+1)
        expect(new_user.email).to eq(@user[:email])
      end
      it "create a new user with the given parameters" do
        body = JSON.parse(response.body)
        expect(body["name"]).to eq(@user[:name])
      end
    end

    context "with invalid password" do
      before do
        @count = User.count
        @user = {
          name: "testuser",
          email: "test@codeanand.com",
          contact_no: 4159102486,
          entity_type: "Restaurant",
          line1: "778, Praderia Cir",
          city: "Fremont",
          state: "CA",
          country: "USA",
          zipcode: 94539
        }
      end

      it "should raise_error" do
       post :create,params: @user
       body = JSON.parse(response.body)
       expect(body).to include("Password can't be blank")
      end
    end
  end
end
