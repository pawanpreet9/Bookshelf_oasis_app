# frozen_string_literal: true

class OrdersController < ApplicationController
  def show
    @order = Order.includes(:customer, :province, :books).find(params[:id])
  end

  def new
    @order = Order.new

    if current_customer
      # Customer is logged in, set the address fields with customer's address
      @order.build_customer(
        address: current_customer.address,
        city: current_customer.city,
        province_id: current_customer.province_id,
        postal_code: current_customer.postal_code
      )

    else
      # Customer is a guest, build a new customer associated with the order
      @order.build_customer
    end

    return unless session[:cart_items].present?

    book_ids_in_cart = session[:cart_items].map { |item| item['book_id'] }
    @order.book_ids = book_ids_in_cart
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

    else
      # If the customer is not logged in, create a new customer based on the order parameters
      @order.build_customer(email: nil, password: nil, address: params[:order][:customer_attributes][:address],
                            city: params[:order][:customer_attributes][:city], province_id: params[:order][:customer_attributes][:province_id], postal_code: params[:order][:customer_attributes][:postal_code])

      @order.address = params[:order][:customer_attributes][:address]
      @order.city = params[:order][:customer_attributes][:city]
      @order.province_id = params[:order][:customer_attributes][:province_id]
      @order.postal_code = params[:order][:customer_attributes][:postal_code]
      @order.customer.province_id = params[:order][:customer_attributes][:province_id] if params[:order][:customer_attributes][:province_id].present?
    end
    # Now, handle the creation of OrderItems
    if session[:cart_items].present?
      session[:cart_items].each do |item|
        book = Book.find_by(id: item['book_id'])
        next unless book # Skip if the book with the given ID is not found

        item['price'] = book.price.to_f
        book_price_history = BookPriceHistory.create(book:, price_at_order_placement: book.price)
        @order.order_items.build(
          book:,
          quantity: item['quantity'],
          historical_book_price: book_price_history.price_at_order_placement,
          tax_rate_history: TaxRateHistory.find_by(id: item['tax_rate_history_id'])
        )
      end
    else
      puts 'session not found'
    end
    if @order.order_items.blank?
      redirect_to cart_items_path, alert: 'Cannot create an order without any books in the cart.'
      return
    end
    puts @order.order_items.inspect

    #  @order.total = @order.total_price
    @order.total = @order.order_items.map(&:total_price).sum

    if @order.save(validate: false)

      session[:cart_items] = []
      redirect_to @order, notice: 'Order was successfully created.'
    else
      puts @order.errors.full_messages
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:other_order_params_you_need,
                                  customer_attributes: %i[address city province_id postal_code])
  end
end
