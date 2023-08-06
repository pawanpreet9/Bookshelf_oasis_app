# frozen_string_literal: true

# Create the about table
class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :abouts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
