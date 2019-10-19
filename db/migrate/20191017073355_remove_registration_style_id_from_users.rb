class RemoveRegistrationStyleIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :registration_style_id, :integer
  end
end
