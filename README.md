# README

## アプリケーション名
furimaアプリ

## アプリケーション概要
商品を登録し、他の人が登録した商品を購入することができる。

## URL
http://54.95.149.127/

## テスト用アカウント他
### ID/Pass
  ID: admin
  Pass: 2222
### テスト用アカウント等
  購入者用 メールアドレス: kaitai@tarou
          パスワード: kaitai0000
  購入用カード情報 番号：4242424242424242
                期限：2025年12月
                セキュリティコード：123
  出品者用  メールアドレス名: uritai@tarou
           パスワード: uritai0000

## アプリケーションの利用方法
WebブラウザGoogle Chromeの最新版を利用してアクセスしてください。
接続先およびログイン情報については、上記の通りです。
同時に複数の方がログインしている場合に、ログインできない可能性があります。
テストアカウントでログイン→トップページから出品ボタン押下→商品情報入力→商品出品
確認後、ログアウト処理をお願いします。

## 目指した課題解決

## 洗い出した要件
https://docs.google.com/spreadsheets/d/1xxGwTBXwLBQE16UiQwEwJUBZ1DhoLfB4utOZJYfTtpc/edit#gid=282075926

## 実装した機能
画像のプレビュー機能表示
画像を選択した時にどのような画像が選択されているか登録する前にわかるようにしている。

## 実装予定の機能

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


## ordersテーブル

| Column | type       | Option                           |
|--------|------------|----------------------------------|
| user   | references | null : false, foreign_key : true |
| item   | references | null : false, foreign_key : true |

### Association

belongs_to: user
belongs_to: item
has_one: destination


## destinationsテーブル（送り先）

| Column      | type       | Option                           |
|-------------|------------|----------------------------------|
| post_number | string     | null : false                     |
| region_id   | integer    | null : false                     |
| city        | string     | null : false                     |
| street      | string     | null : false                     |
| apartment   | string     |                                  |
| telephone   | string     | null : false                     |
| order       | references | null : false, foreign_key : true |

### Association

belongs_to: order, dependent: :destroy

## 開発環境
Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code

