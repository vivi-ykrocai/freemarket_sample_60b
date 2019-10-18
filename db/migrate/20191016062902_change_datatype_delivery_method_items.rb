class ChangeDatatypeDeliveryMethodItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_method, :integer
  end
end
