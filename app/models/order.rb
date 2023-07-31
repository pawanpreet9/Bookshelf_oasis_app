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
  accepts_nested_attributes_for :customer


end
