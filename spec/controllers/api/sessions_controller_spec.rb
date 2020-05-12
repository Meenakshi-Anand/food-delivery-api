require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe "POST create" do
    before do
      @consumer = Consumer.create!()
      @user = User.create!({
        name: "testuser1",
        email: "test123@codeanand.com",
        password: "testing",
        contact_no: 4159102486,
        entity_type: "Consumer",
        entity_id: @consumer.id})
      end

    context "with valid attributes" do
      before do
        post :create,
        params: {
          email: "test123@codeanand.com",
          password: "testing"
        }
        end

      it "should be successful" do
        expect(response).to be_successful
      end

      it "should login to the right user account" do
        body = JSON.parse(response.body)
        expect(body["user"]["name"]).to eq(@user.name)
      end

      it "should include Bearer token" do
        body = JSON.parse(response.body)
        expect(body["jwt"]).not_to be_nil
      end

    end

    context "with invalid email" do
      before do
        post :create,
        params: {
          email: "test1234@codeanand.com",
          password: "testing"
        }
      end

      it "should raise error" do
        body = JSON.parse(response.body)
        expect(body).to include("Invalid Username or Password")
      end

    end

    context "with invalid password" do
      before do
        post :create,
        params: {
          email: "test123@codeanand.com",
          password: "testings"
        }
      end

      it "should raise error" do
        body = JSON.parse(response.body)
        expect(body).to include("Invalid Username or Password")
      end

    end

  end
end
