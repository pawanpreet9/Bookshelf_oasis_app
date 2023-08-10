# frozen_string_literal: true

# Represents an about data  in the system.
class About < ApplicationRecord
  # Validation
  validates :title, :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[content created_at id title updated_at]
  end
end
