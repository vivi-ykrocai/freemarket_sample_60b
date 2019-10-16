class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.string :item_status, null: false
      t.string :delivery_charged, null: false
      t.string :delivery_method, null: false
      t.string :delivery_area, null: false
      t.string :delivery_shipping_date, null: false
      t.integer :total_price
      t.text :item_profile_comment, null: false
      t.string :item_salse_status, null: false
      t.integer :good
      t.integer :buyer_id, foreign_key: true
      t.integer :seller_id, foreign_key: true

      t.timestamps
    end
  end
end













