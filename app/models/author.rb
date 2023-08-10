# frozen_string_literal: true

# Represents an author data in the system.
class Author < ApplicationRecord
  has_many :books

  # Validations
  validates :name, presence: true
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['books']
  end

  def random_image_url
    'https://picsum.photos/200/300'
  end
end
