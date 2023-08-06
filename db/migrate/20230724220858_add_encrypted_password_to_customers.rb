# frozen_string_literal: true

# Add encrypted password to the customer table.
class AddEncryptedPasswordToCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here.
    add_column :customers, :encrypted_password, :string, null: false, default: ''
    add_index :customers, :encrypted_password, unique: true
  end
end
