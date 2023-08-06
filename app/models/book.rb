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

  after_save :record_book_price_change

  private

  def record_book_price_change
    book_price_histories.create(price: price)
  end
  def self.ransackable_attributes(_auth_object = nil)
    %w[author_id created_at description id image pages price publication_date publisher
       quantity title updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[author genres image_attachment image_blob]
  end
end
