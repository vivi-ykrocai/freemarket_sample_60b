class ChangeColumnToAllowNullToAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :prefecture_id, :integer, null: true
    change_column :addresses, :city, :string, null: true
    change_column :addresses, :address, :string, null: true
  end
end
