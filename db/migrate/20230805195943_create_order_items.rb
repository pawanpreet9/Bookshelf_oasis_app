# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
