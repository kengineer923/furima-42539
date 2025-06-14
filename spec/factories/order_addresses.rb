FactoryBot.define do
  factory :order_address do
    postal_code { '100-0001' }
    prefecture_id { 2 }
    city { '千代田区' }
    address { '丸の内1-1' }
    building { '丸の内ビルディング' }
    phone_number { '0312345678' }
    # token {  }
  end
end
