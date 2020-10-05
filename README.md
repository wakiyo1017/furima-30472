# README

## usersテーブル

| Columns          | Type    | Option       |
|------------------|---------|--------------|
| nickname         | string  | null : false |
| email            | string  | null : false |
| password         | string  | null : false |
| first_name_kanji | string  | null : false |
| last_name_kanji  | string  | null : false |
| first_name_kana  | string  | null : false |
| last_name_kana   | string  | null : false |
| birthday         | date    | null : false |

## Association

has_many: items
has_many: tradings


## itemsテーブル

| Column             | type         | Option                           |
|--------------------|--------------|----------------------------------|
| name               | string       | null : false                     |
| description        | text         | null : false                     |
| price              | integer      | null : false                     |
| category_id        | integer      | null : false                     |
| state_id           | integer      | null : false                     |
| shipping_charge_id | integer      | null : false                     |
| region_id          | integer      | null : false                     |
| delivery_days_id   | integer      | null : false                     |
| user               | references   | null : false, foreign_key : true |

### Association

belongs_to: user
has_one: trading


## tradingsテーブル

| Column | type       | Option                           |
|--------|------------|----------------------------------|
| user   | references | null : false, foreign_key : true |
| item   | references | null : false, foreign_key : true |

### Association

belongs_to: user
belongs_to: item
has_one: destination


## destinationsテーブル（送り先）

| Column         | type       | Option                           |
|----------------|------------|----------------------------------|
| post_number    | string     | null : false                     |
| prefecture_id  | integer    | null : false                     |
| city           | string     | null : false                     |
| street         | string     | null : false                     |
| apartment      | string     |                                  |
| telephone      | string     | null : false                     |
| trading        | references | null : false, foreign_key : true |

### Association

belongs_to: trading, dependent: :destroy




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
