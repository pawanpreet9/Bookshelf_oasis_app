class Admin < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "password", "updated_at", "username"]
  end
end
