class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションを追加
  validates :nickname, :last_name, :first_name, :last_kana, :first_kana, :birthday, presence: true
end
