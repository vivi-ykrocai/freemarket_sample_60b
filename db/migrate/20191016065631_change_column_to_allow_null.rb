class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_method, :integer, null: true
    change_column :items, :item_salse_status, :integer, null: true
  end
end
