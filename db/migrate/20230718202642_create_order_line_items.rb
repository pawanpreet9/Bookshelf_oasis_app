class CreateOrderLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_line_items do |t|
      t.integer :order_id
      t.references :book, null: false, foreign_key: true
      t.integer :quantity
      t.string :price

      t.timestamps
    end
  end
end
