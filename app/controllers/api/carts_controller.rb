class Api::CartsController < ApplicationController
  def create
    if current_user.entity_type == "Consumer"
      @cart = Cart.new(consumer_id: current_user.id,restaurant_id: params[:id],order_status:0)
      if @cart.save!
        params[:cart_items].values.each do |item|
          @new_cart_item = CartItem.new(cart_id:@cart.id,food_item_id: item['0'],quantity: item['1'])
        end
        render json:@cart , status: 500
      else
        render json: @cart.errors.full_messages, status: 422
      end
    else
      render json: ["Not authorized to do add items to cart"], status:422
    end
  end

  def update_cart_status
    order = {'not_ordered'=>0,'ordered'=>1,'order_accepted'=>2,'order_denied'=>3}
    if current_user.entity_type == "Consumer"
       status = params[:order_status] if params[:order_status] == "ordered"
    else
       status = params[:order_status] if params[:order_status] == "order_accepted" || params[:order_status] == "order_denied"
    end
    @cart = Cart.find(params[:cart_id])
    if status && @cart && order[status] > order[@cart.order_status]
      @cart.update!(order_status: status)
      if params[:order_status] == "order_accepted"
        @order =  Order.create(consumer_id: current_user.id, restaurant_id: params[:id],cart_id: params[:cart_id],status:0)
        @order.save!
      end
      if @order
        render json: @order , status: 500
      else
        render json: @cart , status: 500
      end
    else
      render json: @cart.errors.full_messages, status: 422
    end
  end
end
