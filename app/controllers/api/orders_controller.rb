class Api::OrdersController < ApplicationController
  def create
    if current_user.entity_type == "Consumer"
      @order = Order.new(consumer_id: current_user.id, restaurant_id: params[:id],cart_id: params[:cart_id],status:0)
      if @order.save!
        render json: @order
      else
        render json: @order.errors.full_messages, status: 422
      end
    else
      render json: ["Not authorized to place order"], status:422
    end
  end

  def update_order_status
    if current_user.entity_type == "Restaurant"
    @order = Order.find(params[:order_id])
    if @order && @order.status != "delivered"
      p @order,params[:status]
      @order.update(status: params[:status])
      render json: @order , status: 500
    else
      render json: @order.errors.full_messages, status: 422
    end
   end
  end
end
