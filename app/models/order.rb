# frozen_string_literal: true

# Represents an orders in the system.
class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_line_items
  has_many :order_items,  dependent: :destroy
  has_many :books, through: :order_items
  has_one :customer_address, through: :customer
  belongs_to :province
  attr_readonly :pst, :gst, :hst, :taxes, :total

  has_many :order_tax_rate_histories, dependent: :destroy  #
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at customer_id description id order_date total updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[customer order_line_items]
  end
  accepts_nested_attributes_for :order_items
  accepts_nested_attributes_for :customer

  def subtotal
    order_items.sum { |item| item.subtotal }
  end


  def total_taxes
    gst_rate = order_items.last&.tax_rates&.first || historical_gst_rate || province&.gst_rate || 0
    pst_rate = order_items.last&.tax_rates&.second || historical_pst_rate || province&.pst_rate || 0
    hst_rate = order_items.last&.tax_rates&.third || historical_hst_rate || province&.hst_rate || 0

    (subtotal * (gst_rate + pst_rate + hst_rate) / 100).round(2)
  end

  def total_price
    subtotal + total_taxes
  end
  def total_gst
    total_taxes * (province.gst_rate || 0) / 100
  end

  def total_pst
    total_taxes * (province.pst_rate || 0) / 100
  end

  def total_hst
    total_taxes * (province.hst_rate || 0) / 100
  end
end
