class Api::ReviewsController < ApplicationController
  def create
    @review = Review.new(description: params[:description],order_id: params[:order_id])
    if current_user.entity_type == "Consumer" && @review.save!
      render json: @review
    else
      render json: @review.errors.full_messages, status: 422
    end
  end
  def update
    @review = Review.find(params[:review_id])
    if current_user.entity_type == "Consumer" && @review
      @review.update(description: params[:description])
      render json: @review
    else
      render json: @review.errors.full_messages, status: 422
    end
  end
  def destroy
    @review = Review.find(params[:review_id])
    if current_user.entity_type == "Consumer" && @review
      @review.destroy
    else
      render json: ["No reviews to delete"], status: 404
    end
  end
end
