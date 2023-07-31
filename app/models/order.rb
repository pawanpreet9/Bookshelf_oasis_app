class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_line_items
  has_one :customer_address, through: :customer

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "description", "id", "order_date", "total", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_line_items"]
  end
  accepts_nested_attributes_for :order_line_items

  def subtotal
    order_items.sum { |item| item.book.price * item.quantity }
  end

  def total
    # Calculate the total price for the order items, including taxes
    subtotal + gst + pst + hst
  end

  private

  def gst
    subtotal * (province.gst_rate / 100)
  end

  def pst
    subtotal * (province.pst_rate / 100)
  end

  def hst
    subtotal * (province.hst_rate / 100)
  end
end
