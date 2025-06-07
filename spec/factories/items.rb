FactoryBot.define do
  factory :item do
    name              { "テスト商品" }
    description       { "テスト商品の説明です" }
    price             { 1000 }
    association       :user
    category_id       { 2 }
    condition_id      { 2 }
    shipping_payer_id { 2 }
    duration_id       { 2 }
    prefecture_id     { 2 }

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
