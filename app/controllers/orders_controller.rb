class OrdersController < ApplicationController
  def checkout
    @order = Order.new
    @cart_items = current_cart.cart_items
    @cart_items.each do |cart_item|
      @order.order_items.build(book_id: cart_item.book_id, quantity: cart_item.quantity)
    end
  end
  def create
    @order = Order.new(order_params)

    if current_customer

      @order.customer = current_customer
    else

      @order.build_customer(customer_params)
    end

    if @order.save

      current_cart.cart_items.destroy_all
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :checkout
    end
  end
  def total_price

    order_items.sum { |item| item.book.price * item.quantity }
  end
  private


  def order_params
    params.require(:order).permit(:customer_id, :address, :city, :province_id, :postal_code,
                                  order_items_attributes: [:book_id, :quantity])
  end
  def customer_params
    params.require(:customer).permit( :email, :address, :city, :province_id, :postal_code)
  end

end
