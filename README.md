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

# メルカリ DB設計
## users table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|nick_name|string|null: false|
|registration_style_id|references|null: false, foreign_key: true|
|email|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|last_name|string|null: false|
|family_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birth_y|string|null: false|
|birth_m|string|null: false|
|birth_d|string|null: false|
|phone_number|string|null: false|
|iine|string|null: false|
|mer_point|string||
|icon_image|string||
|profiile_comments|text||
|number_of_exhibits|string||
|number_of_evaluations|string||
|excerent|string||
|good|string||
|bad|string||

### Association
- has_many :items
- has_many :registration_styles
- has_many :addres_tables
- has_many :knowledges_table
- belong_to :todo_lists_table
- has_many :credit_cards_table