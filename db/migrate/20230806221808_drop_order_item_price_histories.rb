# frozen_string_literal: true

class DropOrderItemPriceHistories < ActiveRecord::Migration[7.0]
  def up
    drop_table :order_item_price_histories
  end

  def down
    create_table :order_item_price_histories do |t|
      t.references :order_item, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
