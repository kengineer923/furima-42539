# README

# テーブル設計
## usersテーブル
| Column             | Type    | Options                  |
| ------------------ | ------  | ------------------------ |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| last_name          | string  | null: false              |
| first_name         | string  | null: false              |
| last_kana          | string  | null: false              |
| first_kana         | string  | null: false              |
| birthday           | date    | null: false              |

### Association
- has_many :items
- has_many :transactions


## items テーブル
| Column            | Type        | Options                        |
| ----------------- | ----------- | ------------------------------ |
| name              | string      | null: false                    |
| description       | text        | null: false                    |
| price             | integer     | null: false                    |
| user              | references  | null: false, foreign_key: true |
| category_id       | integer     | null: false                    |
| condition_id      | integer     | null: false                    |
| shipping_payer_id | integer     | null: false                    |
| duration_id       | integer     | null: false                    |
| prefecture_id     | integer     | null: false                    |

### Association
- belongs_to :user
- has_one :transactions
- has_one_active_hash :category
- has_one_active_hash :condition
- has_one_active_hash :shipping_payer
- has_one_active_hash :duration
- has_one_active_hash :prefecture

## transactions テーブル
| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| item        | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## addressesテーブル
| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| postal_code   | string     | null: false |
| prefecture_id | integer    | null: false |
| city          | string     | null: false |
| street        | text       | null: false |
| building      | text       | null: true  |
| phone_num     | integer    | null: false |
| transaction   | references | null: false, foreign_key: true |

### Association
- belongs_to :transaction
- has_one_active_hash :prefecture

## paymentsテーブル
| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| payment_method | string     | null: false |
| card_num       | string     | null: false |
| transaction    | references | null: false, foreign_key: true |
| user           | references | null: false, foreign_key: true |

### Association
- belongs_to :transaction
- belongs_to :user