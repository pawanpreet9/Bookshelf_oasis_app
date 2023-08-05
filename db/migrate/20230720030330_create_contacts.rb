# frozen_string_literal: true

# Create Contact table.
class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :contacts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
