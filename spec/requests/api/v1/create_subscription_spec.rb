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
      post '/api/v1/subscriptions', params: new_sub
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a(Hash)
      expect(body).to have_key(:data)

      data = body[:data][:attributes]
      expect(data).to have_key(:title)
      expect(data).to have_key(:price)
      expect(data).to have_key(:status)
      expect(data).to have_key(:customer_id)
      expect(data).to have_key(:tea_id)

      expect customer_count + 1 == Customer.all.count
    end
  end
end
