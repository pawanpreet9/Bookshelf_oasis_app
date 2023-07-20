class OrderLineItem < ApplicationRecord
  belongs_to :order

  belongs_to :book


  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "order_id", "price", "quantity", "updated_at"]
  end
end
