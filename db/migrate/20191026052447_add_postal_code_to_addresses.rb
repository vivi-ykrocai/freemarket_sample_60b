class AddPostalCodeToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :postal_code, :integer
  end
end
