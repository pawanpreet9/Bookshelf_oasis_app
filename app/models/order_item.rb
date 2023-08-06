# app/models/order_item.rb

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
   # New field to store the book price at the time of order placement
   belongs_to :book_price_history, optional: true
   belongs_to :tax_rate_history, class_name: 'TaxRateHistory', foreign_key: 'tax_rate_history_id', optional: true

   before_validation :set_historical_data, on: :create
   def subtotal
    historical_book_price || book.price * quantity
  end

  def tax_rates
    historical_gst_rate ||= tax_rate_history&.gst_rate || current_tax_rate_history_for_order(order)&.gst_rate
    historical_pst_rate ||= tax_rate_history&.pst_rate || current_tax_rate_history_for_order(order)&.pst_rate
    historical_hst_rate ||= tax_rate_history&.hst_rate || current_tax_rate_history_for_order(order)&.hst_rate
    [historical_gst_rate || 0, historical_pst_rate || 0, historical_hst_rate || 0]
  end

  def total_taxes
    (subtotal * (tax_rates.sum / 100)).round(2)
  end

  def total_price
    subtotal + total_taxes
  end

  private

  def current_tax_rate_history_for_order(order)
    return tax_rate_history if tax_rate_history.present?

    customer_province = order.customer&.province
    return nil unless customer_province

    TaxRateHistory.for_province(customer_province).order(created_at: :desc).first
  end

  def default_tax_rate_history
    TaxRateHistory.new(gst_rate: 0, pst_rate: 0, hst_rate: 0)
  end

  def set_historical_data
    self.tax_rate_history ||= default_tax_rate_history
    self.historical_gst_rate ||= self.tax_rate_history.gst_rate
    self.historical_pst_rate ||= self.tax_rate_history.pst_rate
    self.historical_hst_rate ||= self.tax_rate_history.hst_rate
    self.historical_book_price ||= book.price
  end


  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "order_id", "quantity", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["book", "book_price_history", "gst_rate_history", "hst_rate_history", "order", "pst_rate_history"]
  end

end

