# frozen_string_literal: true

# Represents an cart item in the system.
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book
end
