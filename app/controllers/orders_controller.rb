class OrdersController < ApplicationController

  def show
    @order = Order.includes(:customer, :province).find(params[:id])
  end
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

    # If the customer is logged in, associate the order with the current_customer
    if current_customer
      @order.customer = current_customer
      @order.address = current_customer.address
      @order.city = current_customer.city
      @order.province_id = current_customer.province_id
      @order.postal_code = current_customer.postal_code
      @order.total = @order.total_price
    else
      # If the customer is not logged in, create a new customer based on the order parameters
      @order.build_customer(email: nil, password: nil)
      @order.total = @order.total_price
      @order.address = params[:order][:customer_attributes][:address]
      @order.city = params[:order][:customer_attributes][:city]
      @order.province_id = params[:order][:customer_attributes][:province_id]
      @order.postal_code = params[:order][:customer_attributes][:postal_code]
      if params[:order][:customer_attributes][:province_id].present?
        @order.customer.province_id = params[:order][:customer_attributes][:province_id]
      end
    end


    if @order.save(validate: false)
      redirect_to  @order, notice: 'Order was successfully created.'
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
