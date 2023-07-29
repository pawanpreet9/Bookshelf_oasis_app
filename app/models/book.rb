class Book < ApplicationRecord
  belongs_to :author

  has_and_belongs_to_many :genres

  has_one_attached :image

  has_many :cart_items, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["author_id", "created_at", "description", "id", "image", "pages", "price", "publication_date", "publisher", "quantity", "title", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["author", "genres", "image_attachment", "image_blob"]
  end
end
