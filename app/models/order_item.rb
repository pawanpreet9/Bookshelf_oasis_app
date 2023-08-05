# app/models/order_item.rb

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "order_id", "quantity", "updated_at"]
  end
end
