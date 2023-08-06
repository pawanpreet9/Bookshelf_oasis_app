# frozen_string_literal: true

# add customer to cart items table.
class AddCustomerToCartItems < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    add_reference :cart_items, :customer, null: false, foreign_key: true
  end
end
