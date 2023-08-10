# frozen_string_literal: true

# Represents an cart item in the system.
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  # Validations
  validates :cart_id, :book_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
