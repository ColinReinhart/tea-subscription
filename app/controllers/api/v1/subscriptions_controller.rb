class Api::V1::SubscriptionsController < ApplicationController

  def create
    sub_create = Subscription.new(sub_params)
    if sub_create.save
      render json: SubscriptionSerializer.new(sub_create), status: 201
    else
      render json: { error: "Error" }, status: :created
    end
  end

  def destroy
    sub = Subscription.find_by(id: params[:id])
    sub.status = "canceled"
    render json: SubscriptionSerializer.new(sub), status: :accepted
  end

  def index
    subs = Subscription.where(customer_id: params[:customer_id])
    render json: SubscriptionSerializer.new(subs), status: :accepted
  end

  private
    def sub_params
      params.permit(:title, :price, :status, :frequency, :customer_id, :tea_id)
    end

end
