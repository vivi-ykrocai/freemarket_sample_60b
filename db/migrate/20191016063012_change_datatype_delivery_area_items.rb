class ChangeDatatypeDeliveryAreaItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_area, :integer
  end
end
