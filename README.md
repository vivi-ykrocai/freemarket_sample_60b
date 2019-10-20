# mercari DB

## users_table
|Column|Type|Options|
|------|----|-------|
|email|string|default: "", null: false|
|encrypted_password|string|default: "", null: false|
|nick_name|string|null: false|
|family_name|string|null: false|
|last_name|string|null: false|
|family_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|iine|string||
|mer_point|string||
|icon_image|string||
|profiile_comments|text||
|number_of_exhibits|integer||
|number_of_evaluations|integer||
|excerent|string||
|good|string||
|bad|string||
|postal_code|string||
|prefectures|string||
|city|string||
|address|string||
|building_name|string||
|reset_password_token|string||
|reset_password_sent_at|datetime||
|remember_created_at|datetime||
|phone_number|string||
|phone_number2|string||
|index [email], name: "index_users_on_email", unique: true|
|index [reset_password_token], name:"index_users_on_reset_password_token", unique: true|


### Association
- has_many :buyed_items, foreign_key: "buyer_id"class_name: "Item"
- has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
- belongs_to_active_hash :prefecture


## addresses_table
|Column|Type|Options|
|------|----|-------|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|apartment_house|string||
|user_id|null: false, foreign_key: true|
|index [user_id], name: "index_addresses_on_user_id"


## items_table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|item_status|integer|null:false|
|delivery_charged|integer|null:false|
|delivery_method|integer||
|delivery_area|string|null:false|
|delivery_shipping_date|integer|null:false|
|total_price|integer||
|item_profile_comment|text|null:false|
|item salse status|integer|null:false|
|good|integer||
|buyer_id|integer||
|seller_id|integer||
|category_id|bigint||
|user_id|integer|null: false, foreign_key: true|
|index [category_id], name: "index_items_on_category_id"



### Association
- belongs_to :category
- has_many :images, dependent: :destroy



## categories_table
|Column|Type|Options|
|------|----|-------|
|name|string||
|ancestry|string||


### Association
- has_many :items
- has_ancestry


## images_table
|Column|Type|Options|
|------|----|-------|
|image|string||
|item_id|bigint|  |
|index [item_id], name: "index_images_on_item_id"|


### Association
- belongs_to :item, optional: true
- mount_uploader :image, ImageUploader