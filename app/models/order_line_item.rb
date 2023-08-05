# frozen_string_literal: true

# Represents an order line items in the system.
class OrderLineItem < ApplicationRecord
  belongs_to :order

  belongs_to :book

  def self.ransackable_attributes(_auth_object = nil)
    %w[book_id created_at id order_id price quantity updated_at]
  end
end
