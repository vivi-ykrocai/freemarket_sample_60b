class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :prefecture_id, null:false
      t.string :city, null:false
      t.string :address, null:false
      t.string :apartment_house
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
