class AddEncryptedPasswordToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :encrypted_password, :string, null: false, default: ""
    add_index :customers, :encrypted_password, unique: true
  end
end
