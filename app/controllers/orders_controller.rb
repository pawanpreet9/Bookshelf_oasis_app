class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_customer_address # Ensure that the customer_address association is built if it's a nested attribute
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_customer

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:other_order_params_you_need, customer_attributes: [:id, :address_line1, :address_line2, :city, :province_id, :postal_code])
  end
end
