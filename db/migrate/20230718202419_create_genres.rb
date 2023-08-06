# frozen_string_literal: true

# create genre model
class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
