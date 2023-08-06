# frozen_string_literal: true

# Creating the cart model.
class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :carts, &:timestamps
  end
end
