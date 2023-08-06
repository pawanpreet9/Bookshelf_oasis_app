# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
