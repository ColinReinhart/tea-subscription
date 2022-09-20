require 'rails_helper'

RSpec.describe 'Subscription request' do
  describe 'happy path' do
    it "creates a new subscription for a customer" do
      customer_count = Customer.all.count
      new_sub = {
        title: "New Sub",
        price: 2000,
        status: "active",
        customer_id: Customer.first.id,
        tea_id: Tea.first.id
      }
      post 'api/v1/customers', params: new_sub
      expect(response).to be_successful
      require "pry"; binding.pry
    end
  end
end
