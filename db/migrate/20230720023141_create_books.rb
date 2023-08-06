# frozen_string_literal: true

# create book model
class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.integer :pages
      t.decimal :price
      t.string :publisher
      t.date :publication_date
      t.references :author, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
