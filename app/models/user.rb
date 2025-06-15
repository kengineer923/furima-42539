class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :items

  # バリデーションを追加
  validates :nickname, :last_name, :first_name, :last_kana, :first_kana, :birthday, presence: true

  # パスワードのバリデーション
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字を両方含む必要があります' }, allow_nil: true

  # 名前(全角)のバリデーション
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  # 名前カナ(全角)のバリデーション
  validates :last_kana, :first_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角（カタカナ）で入力してください' }
end
