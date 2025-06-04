FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    user { nil }
    category_id { 1 }
    condition_id { 1 }
    shipping_payer_id { 1 }
    duration_id { 1 }
    prefecture_id { 1 }
  end
end
