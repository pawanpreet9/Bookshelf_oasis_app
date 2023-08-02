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

  private

  def order_params
    params.require(:order).permit(:other_order_params_you_need, customer_attributes: [:address, :city, :province_id, :postal_code])
  end
end
