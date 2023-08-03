class Province < ApplicationRecord
  has_many :customers
  has_many :orders
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
