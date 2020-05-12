class Api::RestaurantsController < ApplicationController
  skip_before_action :authenticate

  def update_delivery_range
   @restaurant = Restaurant.find(current_user.entity_id)
   if @restaurant
     if @restaurant.update(delivery_range: params[:delivery_range])
       render json: @restaurant
     else
       render json: @restaurant.errors, status: 400
     end
   else
     render json: ["No restaurant found"], status: 404
   end
  end

  def get_menu
    @restaurant = Restaurant.find(params[:id])
    if @restaurant
      @menu = @restaurant.get_menu(params[:meal_category])
      render "api/restaurants/show"
    else
      render json: @restaurant.errors.full_messages, status: 422
    end
  end

  def set_menu
    @user = current_user
    if @user.entity_type == "Restaurant" && @user.entity_id == params[:id].to_i
       @restaurant = Restaurant.find(params[:id])
      if @restaurant
        @menu = @restaurant.get_menu_of_category(params[:meal_category])
        @menu.destroy! if @menu
        @menu = Menu.new(meal_category: params[:meal_category],restaurant_id: params[:id])
        if @menu.save!
          params[:food_items].values.each do |item|
            @new_food_item = @menu.food_items.create(name: item['0'],price: item['1'],description: item['2'])
          end
          render "api/restaurants/menu"
        else
          render json: @menu.errors.full_messages, status: 422
        end
       else
        render json: @restaurant.errors.full_messages, status: 422
       end
     else
        render json: ["Not authorized to set menu for this restaurant"], status: 422
     end
  end

end
