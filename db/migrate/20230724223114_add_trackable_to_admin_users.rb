# frozen_string_literal: true

# add trackable to the admin table
class AddTrackableToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    add_column :admin_users, :sign_in_count, :integer, default: 0, null: false
    add_column :admin_users, :current_sign_in_at, :datetime
    add_column :admin_users, :last_sign_in_at, :datetime
    add_column :admin_users, :current_sign_in_ip, :string
    add_column :admin_users, :last_sign_in_ip, :string
  end
end
