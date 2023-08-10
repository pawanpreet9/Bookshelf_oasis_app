# frozen_string_literal: true

# tax_rate_history.rb

class TaxRateHistory < ApplicationRecord
  belongs_to :province

  # Validations
  validates :gst_rate, :pst_rate, :hst_rate, :province_id, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: true

  def self.for_province(province)
    where(province_id: province.id)
  end
end
