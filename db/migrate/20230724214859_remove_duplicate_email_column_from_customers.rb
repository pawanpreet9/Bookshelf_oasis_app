# frozen_string_literal: true

# Remove the duplicated email field in the customer table.
class RemoveDuplicateEmailColumnFromCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    remove_column :customers, :email
  end
end
