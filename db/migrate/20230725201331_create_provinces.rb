# frozen_string_literal: true

# CreateProvinces migration creates the Provinces table.
class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :provinces do |t|
      t.string :name

      t.timestamps
    end
  end
end
