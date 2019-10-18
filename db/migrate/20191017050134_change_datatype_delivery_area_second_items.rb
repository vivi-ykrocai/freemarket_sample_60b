class ChangeDatatypeDeliveryAreaSecondItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_area, :string
  end
end
