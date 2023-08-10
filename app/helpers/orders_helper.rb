# frozen_string_literal: true

# app/helpers/orders_helper.rb
module OrdersHelper
  def calculate_order_subtotal(order)
    order.order_items.map(&:subtotal).sum
  end
end
