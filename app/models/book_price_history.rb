# book_price_history.rb

class BookPriceHistory < ApplicationRecord
  belongs_to :book
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "created_at", "id", "price", "updated_at"]
  end
end
