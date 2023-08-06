# tax_rate_history.rb

class TaxRateHistory < ApplicationRecord
  belongs_to :province

  def self.for_province(province)
    where(province_id: province.id)
  end


end
