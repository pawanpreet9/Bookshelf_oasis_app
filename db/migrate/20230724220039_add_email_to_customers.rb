# frozen_string_literal: true

# Add email to the customer table.
class AddEmailToCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    add_column :customers, :email, :string
  end
end
