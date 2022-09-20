class SubscriptionSerializer
  include JSONAPI::Serializer

  set_type 'subscriptions'
  attributes  :title,
              :price,
              :status,
              :customer_id,
              :tea_id

end
