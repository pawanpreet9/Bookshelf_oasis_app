# frozen_string_literal: true

# Represents an orders in the system.
class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_line_items
  has_many :order_items
  has_many :books, through: :order_items
  has_one :customer_address, through: :customer
  belongs_to :province
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at customer_id description id order_date total updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[customer order_line_items]
  end
  accepts_nested_attributes_for :order_line_items
  accepts_nested_attributes_for :customer

  def subtotal
    order_line_items.sum(&:total_price)
  end

  def total_taxes
    if customer&.province
      gst_rate = customer.province.gst_rate || 0
      pst_rate = customer.province.pst_rate || 0
      hst_rate = customer.province.hst_rate || 0

      subtotal * (gst_rate + pst_rate + hst_rate)
    else
      0
    end
  end

  def total_price
    subtotal + total_taxes
  end

  def total_gst
    total_taxes * (customer.province.gst_rate || 0)
  end

  def total_pst
    total_taxes * (customer.province.pst_rate || 0)
  end

  def total_hst
    total_taxes * (customer.province.hst_rate || 0)
  end
end
