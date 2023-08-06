# frozen_string_literal: true

# db/migrate/20230725204936_add_address_fields_to_customer.rb
# Add address fields to the Customer table.
class AddAddressFieldsToCustomer < ActiveRecord::Migration[7.0]
  def change
    # migration code here.
    add_column :customers, :city, :string
    add_column :customers, :postal_code, :string
  end
end
