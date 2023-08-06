# frozen_string_literal: true

# db/migrate/20230725202452_add_province_fields_to_customer.rb
# Add province to customer table.
class AddProvinceToCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here.
    add_reference :customers, :province, null: false, foreign_key: true
  end
end
