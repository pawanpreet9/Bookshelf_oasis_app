class OrdersController < ApplicationController
  def new
    @order = Order.new

    if current_customer
      # Customer is logged in, set the address fields with customer's address
      @order.build_customer(address: current_customer.address, city: current_customer.city, province_id: current_customer.province_id, postal_code: current_customer.postal_code)
    else
      # Customer is a guest, build a new customer associated with the order
      @order.build_customer
    end
  end

end
