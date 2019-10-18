class ChangeDatatypeItemStatusItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :item_status, :integer
  end
end
