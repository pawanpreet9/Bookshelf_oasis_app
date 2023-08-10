# frozen_string_literal: true

# book_price_history.rb

class BookPriceHistory < ApplicationRecord
  belongs_to :book
  # Validations
  validates :price, :book_id, :price_at_order_placement, presence: true
  validates :price, :price_at_order_placement, numericality: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[book_id created_at id price updated_at]
  end
end
