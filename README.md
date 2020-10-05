# README

## usersテーブル

| Columns    | Type    | Option       |
|------------|---------|--------------|
| nickname   | string  | null : false |
| email      | string  | null : false |
| password   | string  | null : false |
| name_kanji | string  | null : false |
| name_kana  | string  | null : false |
| birthday   | integer | null : false |

## Association

has_many: items
has_one: destination


## itemsテーブル

| Column      | type         | Option       |
|-------------|--------------|--------------|
| image       | ActiveStrong |              |
| name        | string       | null : false |
| description | text         | null : false |
| price       | integer      | null : false |
| user_id     | reference    |              |

### Association

belongs_to: user
has_one: destination
has_one: card
has_one: tag


## destinationsテーブル（送り先）

| Column      | type    | Option       |
|-------------|---------|--------------|
| post_number | integer | null : false |
| prefecture  | string  | null : false |
| city        | string  | null : false |
| street      | text    | null : false |
| apartment   | text    | null : false |
| telephone   | integer | null : false |

### Association

## cardsテーブル

| Column         | type    | Option       |
|----------------|---------|--------------|
| card_number    | integer | null : false |
| deadline_day   | integer | null : false |
| sexuality_code | integer | null : false |

### Association


## tagsテーブル

| Column          | type      | Option       |
|-----------------|-----------|--------------|
| category        | integer   | null : false |
| state           | integer   | null : false |
| shipping_charge | integer   | null : false |
| region          | integer   | null : false |
| delivery_days   | integer   | nill : false |
| item_id         | reference |              |

### Association




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
