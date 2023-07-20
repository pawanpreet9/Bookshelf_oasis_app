class Author < ApplicationRecord
  has_many :books
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end

  def random_image_url
    "https://picsum.photos/200/300"
  end
end
