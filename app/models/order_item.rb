# frozen_string_literal: true

# app/models/order_item.rb

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
  # New field to store the book price at the time of order placement
  belongs_to :book_price_history, class_name: 'BookPriceHistory', optional: true
  belongs_to :tax_rate_history, class_name: 'TaxRateHistory', optional: true

  # Validations
  validates :order_id, :book_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
  validates :historical_book_price, numericality: true
  before_validation :set_historical_data, on: :create
  def subtotal
    book_price_at_order_placement * quantity
  end

  def tax_rates
    historical_gst_rate ||= tax_rate_history&.gst_rate || order.gst_rate || 0
    historical_pst_rate ||= tax_rate_history&.pst_rate || order.pst_rate || 0
    historical_hst_rate ||= tax_rate_history&.hst_rate || order.hst_rate || 0
    [historical_gst_rate, historical_pst_rate, historical_hst_rate]
  end

  def total_taxes
    (subtotal * (tax_rates.sum / 100)).round(2)
  end

  def total_price
    subtotal + total_taxes
  end

  private

  def self.current_tax_rate_history_for_order(order)
    # Fix the association between OrderItem and TaxRateHistory
    return order.order_items.last&.tax_rate_history if order.order_items.last&.tax_rate_history.present?

    customer_province = order.customer&.province
    return nil unless customer_province

    TaxRateHistory.for_province(customer_province).order(created_at: :desc).first
  end

  def default_tax_rate_history
    province = order.customer&.province || Province.find_by(id: order.province_id)
    TaxRateHistory.new(gst_rate: province.current_gst_rate, pst_rate: province.current_pst_rate, hst_rate: province.current_hst_rate)
  end

  def set_historical_data
    # Backup book price at the time of order placement
    self.book_price_history = BookPriceHistory.create(book:, price_at_order_placement: book.price)

    # Backup tax rate at the time of order placement
    self.tax_rate_history = TaxRateHistory.create(
      province: order.customer&.province || Province.find_by(id: order.province_id),
      gst_rate: current_tax_rate_history_for_order(order)&.gst_rate,
      pst_rate: current_tax_rate_history_for_order(order)&.pst_rate,
      hst_rate: current_tax_rate_history_for_order(order)&.hst_rate
    )
  end

  protected

  def book_price_at_order_placement
    book_price_history&.price_at_order_placement || historical_book_price || book.price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[book_id created_at id order_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[book book_price_history gst_rate_history hst_rate_history order pst_rate_history]
  end
end
