# frozen_string_literal: true

# Represents an customers in the system.
class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  has_many :orders

  # Validation
  validates :email, :encrypted_password, :province_id, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, length: { minimum: 2 }
  validates :province_id, numericality: { only_integer: true }

  def guest_customer?
    !persisted?
  end
  validates :email, presence: true, unless: :guest_customer?

  belongs_to :province
  def initialize(attributes = nil)
    super
    set_default_email_and_password
  end

  private

  def set_default_email_and_password
    self.email ||= generate_guest_email
    self.password ||= generate_guest_password
  end

  # Generate a unique guest email based on the current timestamp
  def generate_guest_email
    "guest_#{Time.now.to_i}@example.com"
  end

  # Generate a random password for guest customers
  def generate_guest_password
    SecureRandom.hex(8)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[address created_at email id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['orders']
  end
end
