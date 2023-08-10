# frozen_string_literal: true

# Represents an genres in the book.
class Genre < ApplicationRecord
  has_and_belongs_to_many :books

  # Validation
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['books']
  end
end
