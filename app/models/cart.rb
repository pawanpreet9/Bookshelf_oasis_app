# frozen_string_literal: true

# Represents an cart in the system.
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  # Validations
  validates :id, presence: true
end
