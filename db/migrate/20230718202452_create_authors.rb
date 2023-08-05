# frozen_string_literal: true

# Create author model
class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :authors do |t|
      t.string :name

      t.timestamps
    end
  end
end
