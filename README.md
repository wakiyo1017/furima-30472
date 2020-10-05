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

| Column          | type         | Option             |
|-----------------|--------------|--------------------|
| image           | ActiveStrong |                    |
| name            | string       | null : false       |
| description     | text         | null : false       |
| price           | integer      | null : false       |
| category        | integer      | null : false       |
| state           | integer      | null : false       |
| shipping_charge | integer      | null : false       |
| region          | integer      | null : false       |
| delivery_days   | integer      | nill : false       |
| user            | reference    | foreign_key : true |

### Association

belongs_to: user
has_one: trading


## tradingsテーブル

| Column | type      | Option             |
|--------|-----------|--------------------|
| user   | reference | foreign_key : true |
| item   | reference | foreign_key : true |

### Association

belongs_to: user
has_one: destination


## destinationsテーブル（送り先）

| Column      | type    | Option       |
|-------------|---------|--------------|
| post_number | integer | null : false |
| prefecture  | string  | null : false |
| city        | string  | null : false |
| street      | string  | null : false |
| apartment   | string  |              |
| telephone   | integer | null : false |

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
