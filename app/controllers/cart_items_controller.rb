class CartItemsController < ApplicationController
  def index
    cart_items = session[:cart_items] || []
    @cart_items = cart_items.map do |item|
      book = Book.find_by(id: item['book_id'])
      item.merge(book_title: book&.title, book_price: book&.price)

    end
    @total_price = calculate_total_price
  end

  def create
    book = Book.find(params[:book_id])
    @cart_items = session[:cart_items] || []
    @cart_item = @cart_items.find { |item| item['book_id'] == book.id }
    book_price = book.price.to_f
    if @cart_item.nil?
      @cart_items << { 'book_id' => book.id, 'quantity' => 1 , book_title: book.title,book_price: book.price  }
    else
      @cart_item['quantity'] += 1
    end

    session[:cart_items] = @cart_items
    redirect_to cart_items_path, notice: 'Book added to cart.'
  end

  def update
    @cart_items = session[:cart_items] || []
    @cart_item = @cart_items.find { |item| item['book_id'] == params[:id].to_i }

    if @cart_item
      new_quantity = params[:quantity].to_i


      new_quantity = 1 if new_quantity < 1

      @cart_item['quantity'] = new_quantity
    end

    session[:cart_items] = @cart_items
    redirect_to cart_items_path
  end
  def destroy
    @cart_items = session[:cart_items] || []
    @cart_items.reject! { |item| item['book_id'] == params[:id].to_i }

    session[:cart_items] = @cart_items
    redirect_to cart_items_path, notice: 'Book removed from cart.'
  end
   def calculate_total_price
    total_price = 0.0
    @cart_items.each do |item|
      book_price = BigDecimal(item['book_price'].to_s)  # Convert to BigDecimal for precise calculations
      quantity = item['quantity'].to_i
      total_price += (book_price * quantity)
    end
    total_price
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:book_id, :quantity)
  end
end
