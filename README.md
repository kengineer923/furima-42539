# README

# テーブル設計
## usersテーブル
| Column             | Type    | Options     |
| ------------------ | ------  | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| last_kana          | string  | null: false |
| first_kana         | string  | null: false |
| birth_year         | integer | null: false |
| birth_month        | integer | null: false |
| birth_day          | integer | null: false |

### Association
- has_many :items
- has_many :transactions


## items テーブル
| Column      | Type       | Options     |
| ----------  | ---------- | ----------- |
| name        | string     | null: false |
| description | text       | null: false |
| price       | integer    | null: false |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :transactions
- belong_to_active_has :categories
- belong_to_active_has :conditions
- belong_to_active_has :shipping_payers
- belong_to_active_has :prefectures

## transactions テーブル
| Column           | Type       | Options     |
| ---------------- | ---------- | ----------- |
| item_id          | references | null: false, foreign_key: true |
| seller_id        | references | null: false, foreign_key: true |
| buyer_id         | references | null: false, foreign_key: true |
| shipping_id      | references | null: false, foreign_key: true |
| payment_id       | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- belongs_to :items
- belongs_to :payments
- belongs_to :addresses

## addressesテーブル
| Column      | Type       | Options     |
| ----------  | ---------- | ----------- |
| postal_code | string     | null: false |
| prefecture | string     | null: false |
| address     | text       | null: false |
| user_id     | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_many :transactions
- belong_to_active_has :prefectures

## paymentsテーブル
| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| payment_method | string     | null: false |
| card_num       | string     | null: false |
| user_id        | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :transactions