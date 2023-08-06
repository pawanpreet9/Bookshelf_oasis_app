# frozen_string_literal: true

# Create customer table
class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
