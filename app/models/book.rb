# frozen_string_literal: true

# Represents an books data in the system.
class Book < ApplicationRecord
  belongs_to :author

  has_and_belongs_to_many :genres

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :book_price_histories, dependent: :destroy
  # Validations

  validates :title, :quantity, :price, :author_id, presence: true
  validates :quantity, :pages, numericality: { only_integer: true }
  validates :price, numericality: true

  def current_price
    book_price_histories.last&.price || price
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[author_id created_at description id image pages price publication_date publisher
       quantity title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[author genres image_attachment image_blob]
  end
end
