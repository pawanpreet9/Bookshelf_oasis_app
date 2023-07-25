class Province < ApplicationRecord
  has_many :customers
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
