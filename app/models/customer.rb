class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  def guest_customer?
    !persisted?
  end
  validates :email, presence: true, unless: :guest_customer?
  validates :password, presence: true, unless: :guest_customer?


  belongs_to :province

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
