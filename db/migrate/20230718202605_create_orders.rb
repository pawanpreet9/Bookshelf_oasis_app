# frozen_string_literal: true

# create order table
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    # migration code
    create_table :orders do |t|
      t.date :order_date
      t.integer :total
      t.string :description
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
