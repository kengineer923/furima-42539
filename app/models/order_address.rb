class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token,
                :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  extend ActiveModel::Naming
  include ActiveModel::Translation

  def self.i18n_scope
    :activerecord
  end

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid." }
  end

  def save
    return false unless valid?

    order = Order.new(user_id: user_id, item_id: item_id)
    unless order.save
      return false
    end

    address_record = Address.new(
      order_id: order.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: self.address,
      building: building,
      phone_number: phone_number
    )

    unless address_record.save
      return false
    end

    true # すべて成功
  end
end