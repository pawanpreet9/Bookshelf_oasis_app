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
    @order.customer = current_customer

    if @order.save
      # Empty the cart after successful order creation
      current_cart.cart_items.destroy_all
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end
  def total_price
    # Calculate the total price for the order items, including taxes
    order_items.sum { |item| item.book.price * item.quantity }
  end
  private


  def order_params
    params.require(:order).permit(:customer_id, :address, :city, :province_id, :postal_code,
                                  order_items_attributes: [:book_id, :quantity])
  end

end
