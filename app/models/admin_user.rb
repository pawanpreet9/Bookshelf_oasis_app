# frozen_string_literal: true

# Represents an administrator user in the system.
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  # Validations
  validates :email, :encrypted_password, presence: true

  validates :encrypted_password, length: { minimum: 6 }
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id remember_created_at reset_password_sent_at
       reset_password_token updated_at]
  end
end
