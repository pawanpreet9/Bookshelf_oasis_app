# frozen_string_literal: true

# Represents an provinces in the system.
class Province < ApplicationRecord
  has_many :customers
  has_many :orders
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end
end
