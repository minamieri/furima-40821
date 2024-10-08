
## users テーブル

| Column                     | Type   | Options                   |
| -------------------------  | ------ | ------------------------- |
| nickname                   | string | null: false               |
| email                      | string | null: false, unique: true |
| encrypted_password         | string | null: false               |
| birthday                   | date   | null: false               |
| full_width_firstname       | string | null: false               |
| full_width_lastname        | string | null: false               |
| katakana_firstname         | string | null: false               |
| katakana_lastname          | string | null: false               |

### Association

- has_many :products
- has_many :order_history

## products テーブル

| Column             | Type       | Options                        |
| ---------------    | ---------- | ------------------------------ |
| product_name       | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| area_id            | integer    | null: false                    |
| day_id             | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :shipping

## order_histries テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| product  | references | null: false, foreign_key: true |
| user     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :shipping
- belongs_to :product

## shippings テーブル

| Column        | Type       | Options                        |
| ------------  | ---------- | -----------------------------  |
| post_code     | string     | null: false                    |
| area_id       | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| tel           | string     | null: false                    |
| order_history | references | null: false, foreign_key: true |

### Association

- belongs_to :order_history
