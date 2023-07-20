class Genre < ApplicationRecord
  has_and_belongs_to_many :books


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end
end
