# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, address: Faker::Address.full_address)

Tea.create!(title: Faker::Tea.variety, description: Faker::ChuckNorris.fact, temperature: Faker::Number.between(from: 190, to: 220), brew_time: Faker::Number.between(from: 8, to: 16))

Subscription.create!(title: "Colin's Sub", price: Faker::Number.between(from: 20, to: 50), status: "active", customer: Customer.first, tea: Tea.first)
