class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nick_name, null: false
      t.integer :registration_style_id, foreign_key: true, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :family_name, null: false
      t.string :last_name, null: false
      t.string :family_name_kana, null: false
      t.string :last_name_kana, null: false
      t.string :birth_y, null: false
      t.string :birth_m, null: false
      t.string :birth_d, null: false
      t.integer :phone_number, null: false
      t.string :iine
      t.string :mer_point
      t.string :icon_image
      t.text :profiile_comments
      t.integer :number_of_exhibits
      t.integer :number_of_evaluations
      t.string :excerent
      t.string :good
      t.string :bad
      t.timestamps
    end
  end
end
