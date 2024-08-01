# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| birthday           | string | null: false               |

### Association

- has_many :products
- has_many :shopping
- has_one  :shipping

## products テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| product_name  | string     | null: false                   |
| category     | string     | null: false                    |
| price        | string     | null: false                    |
| seller       | string     | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :shipping

## shopping テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| buyer  | string     | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :shipping

## shipping テーブル

| Column  | Type       | Options     |
| ------- | ---------- | ----------- |
| address | string     | null: false |
| tel     | references | null: false |
| buyer   | string     | null: false |

### Association

- belongs_to :product
- belongs_to :user
- belongs_to :shopping
