# frozen_string_literal: true

# Represents an provinces in the system.
class Province < ApplicationRecord
  has_many :customers
  has_many :orders

  has_many :tax_rate_histories, dependent: :destroy
  # Validation
  validates :name, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, presence: true, numericality: true

  def current_tax_rate_history
    tax_rate_histories.order(created_at: :desc).first
  end

  def current_gst_rate
    tax_rate_histories.last&.gst_rate || gst_rate
  end

  def current_pst_rate
    tax_rate_histories.last&.pst_rate || pst_rate
  end

  def current_hst_rate
    tax_rate_histories.last&.hst_rate || hst_rate
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end
end
