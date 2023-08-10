# frozen_string_literal: true

class AddPriceAtOrderPlacementToBookPriceHistories < ActiveRecord::Migration[7.0]
  def change
    add_column :book_price_histories, :price_at_order_placement, :decimal
  end
end
