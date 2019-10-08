# mercari DB
## users_table
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
- has_one :registration_styles
- belong_to :addres
- has_many :credit_cards


## registration_style
|Column|Type|Options|
|------|----|-------|
|fb_acount|string||
|google_acount|string||
|mail_adress|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belong_to :user


## addres_table
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|
|city|string|null: false|
|addres|string|null: false|
|apartment_house|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belong_to :user


## credit_cards_table
|Column|Type|Options|
|------|----|-------|
|credit_card_number|string||
|expiration_date|string||
|secrity_cord|string||
|user_id|references|null: false, foreign_key: true|

### Association
- belong_to :user


## items_table
|Column|Type|Options|
|------|----|-------|
|image|text||
|name|string|null: false|
|category|string|null:false|
|brand|string||
|item_status|string|null:false|
|delivery_charged|string|null:false|
|delivery_method|string|null:false|
|delivery_area|string|null:false|
|estimated_shipping_date|string|null:false|
|total_price|integer||
|item_profile_comment|text|null:false|
|comments on item|text||
|item salse status|string|null:false|
|good|integer||
|user_id|references|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- has_many :comments
- belongs_to :categorie


## comments_table
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|integer|null: false, foreign_key: true|
|item_id|references|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item


## categories_table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association
- has_many :items