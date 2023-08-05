# frozen_string_literal: true

# db/migrate/20230729195303_change_customer_id_nullable_in_cart_items.rb
# Change customer id to nullable in cart items table.
class ChangeCustomerIdNullableInCartItems < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    change_column_null :cart_items, :customer_id, true
  end
end
