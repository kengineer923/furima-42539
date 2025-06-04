FactoryBot.define do
  factory :user do
    nickname              { 'テストユーザー' }
    email                 { Faker::Internet.unique.email }
    password              { 'a1b2c3' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_kana             { 'ヤマダ' }
    first_kana            { 'タロウ' }
    birthday              { '1990-01-01' }
  end
end