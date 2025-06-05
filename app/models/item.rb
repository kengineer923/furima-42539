class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_payer
  belongs_to_active_hash :duration
  belongs_to_active_hash :prefecture

  validates :image, :name, :description, :price, presence: true
  validates :category_id, :condition_id, :shipping_payer_id, :duration_id, :prefecture_id,
            numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end