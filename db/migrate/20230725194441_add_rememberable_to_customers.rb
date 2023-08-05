# frozen_string_literal: true

# add remeerbable to the customer table
class AddRememberableToCustomers < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    add_column :customers, :remember_created_at, :datetime
  end
end
