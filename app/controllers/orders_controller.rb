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
  def create
    @order = Order.new(order_params)
    @order.customer = current_customer if current_customer

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      puts @order.errors.full_messages
      render :new
    end
  end
  def total_price_with_taxes
    # Calculate the total price of the order items
    total_price = order_items.sum(&:total_price)

    # Calculate taxes based on the customer's province
    if customer && customer.province
      gst_rate = customer.province.gst_rate || 0
      pst_rate = customer.province.pst_rate || 0
      hst_rate = customer.province.hst_rate || 0

      total_price += total_price * (gst_rate + pst_rate + hst_rate)
    end

    total_price
  end

  private

  def order_params
    params.require(:order).permit(:other_order_params_you_need, customer_attributes: [:address, :city, :province_id, :postal_code])
  end
end
