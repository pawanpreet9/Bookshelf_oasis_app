# frozen_string_literal: true

class CreateTaxRateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :tax_rate_histories do |t|
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
