class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.build_customer unless current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_customer if current_customer

    if @order.save(validate: false)
      redirect_to @order, notice: 'Order was successfully created.'
    else
      puts @order.errors.full_messages
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:other_order_params_you_need, customer_attributes: [:address,  :city, :province_id, :postal_code])
  end
end
