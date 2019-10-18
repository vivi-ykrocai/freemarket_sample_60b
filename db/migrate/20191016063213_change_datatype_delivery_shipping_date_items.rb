class ChangeDatatypeDeliveryShippingDateItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_shipping_date, :integer
  end
end
