class CreateBookPriceHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :book_price_histories do |t|
      t.decimal :price
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
