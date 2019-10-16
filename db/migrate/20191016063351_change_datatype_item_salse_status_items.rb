class ChangeDatatypeItemSalseStatusItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :item_salse_status, :integer
  end
end
