# frozen_string_literal: true

class CreateOrderItemPriceHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :order_item_price_histories do |t|
      t.references :order_item, null: false, foreign_key: true
      t.decimal :book_price
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate

      t.timestamps
    end
  end
end
