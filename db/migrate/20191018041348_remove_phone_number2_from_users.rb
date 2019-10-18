class RemovePhoneNumber2FromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :phone_number2, :integer
    add_column :users, :phone_number2, :string

  end
end
