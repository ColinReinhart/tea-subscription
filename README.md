# Tea Subscription API
Tea Subscription API was a take home technical challenge desgined to be completed within an 8 hour time limit to demonstrate:

- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

Once the setup instructions below have been completed you will be able to make API calls to:
- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)


## Tech Stack
Built with:
  - Ruby 2.7.4
  - Rails 5.2.6


## Setup
1. Ensure that you have the prerequisites or equivalent
2. Clone this repo to your local and open from the command line
3. Run `bundle install`
4. Run `rails db:{drop,create,migrate,seed}`
5. (Optional) To run the test suite, run `bundle exec rspec`
6. Run `rails s`

You will be able to hit the API on your browser or Postman at `http://localhost:3000`


## Database Schema
![Database Schema Image](/images/database_diagram.png "Database Image")


# Endpoints

## Subscribe a customer to a tea subscription
### POST /api/v1/subscriptions
- Required Params
  - `title`, `price`, `frequency`, `customer_id`, `tea_id`
  - Send required data in JSON format in the body of the request as displayed in the example below
- Example Request
  - `POST http://localhost:3000/api/v1/subscriptions`
  ```ruby
  body: {
    "title": "New Sub",
    "price": 2000,
    "status": "active",
    "frequency": "monthly",
    "customer_id": 1,
    "tea_id": 1
  }
  ```
- Example Response
  ```JSON
  {
      "data": {
          "id": 8,
          "type": "subscription",
          "attributes": {
              "title": "New Sub",
              "price": 2000,
              "status": "active",
              "frequency": "monthly",
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
  ```
<br></br>

## Cancel a customer’s tea subscription
### PATCH /api/v1/subscriptions/1
- Required Params
  - N/A
- Example Request
  - `PATCH http://localhost:3000/api/v1/subscriptions/1`
  - Does not remove record, just changes status to cancelled.
- Example Response
  ```JSON
  {
      "data": {
          "id": "1",
          "type": "subscription",
          "attributes": {
              "title": "New Sub",
              "price": 2000,
              "status": "canceled",
              "frequency": "monthly",
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
  ```
  <br></br>

## See all of a customer’s subscriptions (active and cancelled)
### POST /api/v1/customers/1/subscriptions
- Required Params
  - N/A
- Example Request
  - `GET http://localhost:3000/api/v1/customers/1/subscriptions`
- Example Response
  ```JSON
  {
      "data": [
          {
              "id": "1",
              "type": "subscription",
              "attributes": {
                  "title": "New Sub",
                  "price": 2000,
                  "status": "cancelled",
                  "frequency": "monthly",
                  "customer_id": 1,
                  "tea_id": 1
              }
          }, ...
      ]
  }
  ```
