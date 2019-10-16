class ChangeDatatypeDeliveryChargedItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_charged, :integer
  end
end
