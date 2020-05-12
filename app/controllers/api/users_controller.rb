class Api::UsersController < ApplicationController
  skip_before_action :authenticate

  def create
   @entity = params[:entity_type] == "Restaurant" ? Restaurant.new : Consumer.new
   @entity.save!
   @user = User.new(user_params)
   @user.entity_id = @entity.id
   if @user.save
     @address = Address.new(address_params)
     @address.user_id = @user.id
     if @address.save
       AddressWorker.perform_async(@address.id)
       render json: @user
     else
       render json: @address.errors.full_messages, status: 422
     end

   else
     render json: @user.errors.full_messages, status: 422
   end
 end

 def show
   @user = User.find(params[:id])
 end

 def update_contact_number
    @user = current_user
    if @user
      if @user.update(contact_no: params[:contact_no])
        render :show
      else
        render json: @user.errors, status: 400
      end
    else
      render json: ["No user found"], status: 404
    end
  end

  def update_address
    @user = current_user
    @address = @user.address
    if @address
      if @address.update(address_params)
        render "api/address/show"
      else
        render json: @address.errors, status: 400
      end
    else
      render json: ["Cannot find address"], status: 404
    end
  end

  def get_delivering_restaurants
    @restaurants = current_user.get_delivering_restaurants
    if @restaurants
      render json: @restaurants
    else
      render json: @item.errors.full_messages, status: 422
    end
  end

  def address_params
    params.permit(:line1,:line2,:city,:state,:country,:zipcode)
  end
  def user_params
    params.permit(:email,:password,:name,:contact_no,:entity_type)
  end
end
