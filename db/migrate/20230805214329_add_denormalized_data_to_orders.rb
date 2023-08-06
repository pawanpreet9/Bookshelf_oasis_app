class AddDenormalizedDataToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :product_prices, :text
    add_column :orders, :gst_rate, :decimal
    add_column :orders, :pst_rate, :decimal
    add_column :orders, :hst_rate, :decimal
  end
end