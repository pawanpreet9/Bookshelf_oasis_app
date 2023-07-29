class ChangeCustomerIdNullableInCartItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cart_items, :customer_id, true
  end
end
