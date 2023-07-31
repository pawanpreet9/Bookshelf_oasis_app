class AddAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :address, :string
    add_column :orders, :city, :string
    add_column :orders, :province_id, :integer
    add_column :orders, :postal_code, :string
  end
end
