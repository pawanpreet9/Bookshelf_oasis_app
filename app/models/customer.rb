class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  has_many :orders
  def guest_customer?
    !persisted?
  end
  validates :email, presence: true, unless: :guest_customer?
  validates :password, presence: true, unless: :guest_customer?


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

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
