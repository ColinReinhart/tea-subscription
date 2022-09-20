class Api::V1::SubscriptionsController < ApplicationController

  def create
    sub_create = Subscription.new(sub_params)
    if sub_create.save
      render json: SubscriptionSerializer.new(sub_create), status: 201
    else
      render json: { error: "Error" }, status: 401
    end
  end

  private
    def sub_params
      params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
    end

end
