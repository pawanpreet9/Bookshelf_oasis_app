class Customer < ApplicationRecord
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
