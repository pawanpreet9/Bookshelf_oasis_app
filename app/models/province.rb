# frozen_string_literal: true

# Represents an provinces in the system.
class Province < ApplicationRecord
  has_many :customers
  has_many :orders

   has_many :tax_rate_histories, dependent: :destroy

   after_save :record_tax_rate_change

   private

   def record_tax_rate_change
     tax_rate_histories.create(gst_rate: gst_rate, pst_rate: pst_rate, hst_rate: hst_rate)
   end
   private

   def set_tax_rates_at_order
     self.gst_rate_at_order = gst_rate
     self.pst_rate_at_order = pst_rate
     self.hst_rate_at_order = hst_rate
   end
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end
end
