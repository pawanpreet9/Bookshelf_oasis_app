# app/models/order_item.rb

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book
   # New field to store the book price at the time of order placement
   belongs_to :book_price_history, optional: true
   belongs_to :gst_rate_history, optional: true
   belongs_to :pst_rate_history, optional: true
   belongs_to :hst_rate_history, optional: true

   before_validation :set_historical_data, on: :create

   private

   def set_historical_data
     self.book_price_at_order = book.price
     self.gst_rate_at_order = book.province.tax_rate_histories.last&.gst_rate
     self.pst_rate_at_order = book.province.tax_rate_histories.last&.pst_rate
     self.hst_rate_at_order = book.province.tax_rate_histories.last&.hst_rate
   end
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "order_id", "quantity", "updated_at"]
  end
end
