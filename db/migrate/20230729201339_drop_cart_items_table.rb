# frozen_string_literal: true

class DropCartItemsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :cart_items
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
