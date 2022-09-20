require 'rails_helper'

RSpec.describe 'Subscription request' do
  describe 'happy path' do
    before :each do
      @customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)
      @customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)
      @customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)

      @tea_1 = Tea.create!(title: Faker::Tea.variety, description: Faker::ChuckNorris.fact, temperature: Faker::Number.between(from: 190, to: 220), brew_time: Faker::Number.between(from: 8, to: 16))
      @tea_2 = Tea.create!(title: Faker::Tea.variety, description: Faker::ChuckNorris.fact, temperature: Faker::Number.between(from: 190, to: 220), brew_time: Faker::Number.between(from: 8, to: 16))
      @tea_3 = Tea.create!(title: Faker::Tea.variety, description: Faker::ChuckNorris.fact, temperature: Faker::Number.between(from: 190, to: 220), brew_time: Faker::Number.between(from: 8, to: 16))

      @sub_1 = Subscription.create!(title: "#{@customer_1.first_name}'s First Sub", price: Faker::Number.between(from: 20, to: 50), status: "active", frequency: "weekly", customer: @customer_1, tea: @tea_1)
      @sub_2 = Subscription.create!(title: "#{@customer_1.first_name}'s Second Sub", price: Faker::Number.between(from: 20, to: 50), status: "canceled", frequency: "weekly", customer: @customer_1, tea: @tea_2)
      @sub_3 = Subscription.create!(title: "#{@customer_2.first_name}'s First Sub", price: Faker::Number.between(from: 20, to: 50), status: "active", frequency: "weekly", customer: @customer_2, tea: @tea_3)
    end

    it "creates a new subscription for a customer" do
      sub_count = Subscription.all.count
      new_sub = {
        title: "New Sub",
        price: 2000,
        status: "active",
        frequency: "monthly",
        customer_id: @customer_2.id,
        tea_id: @tea_3.id
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

      expect sub_count + 1 == Subscription.all.count
    end

    it "can change status to canceled" do
      delete "/api/v1/subscriptions/#{@sub_1.id}"

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data][:attributes][:status]).to eq("canceled")
    end

    it "can return all of one customers subscriptions regardless of status" do

      get "/api/v1/customers/#{@customer_1.id}/subscriptions"
      body = JSON.parse(response.body, symbolize_names: true)
      data = body[:data]
      expect(data.count).to eq(2)
      expect(data.first[:attributes]).to have_key(:title)
      expect(data.first[:attributes]).to have_key(:price)
      expect(data.first[:attributes]).to have_key(:status)
      expect(data.first[:attributes]).to have_key(:frequency)
    end
  end
end
