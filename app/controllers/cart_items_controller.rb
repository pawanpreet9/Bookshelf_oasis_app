class CartItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]
  def index
    @cart_items = current_cart.cart_items # Assuming you have a method to get the current cart and its items
  end
  def create
    book = Book.find(params[:book_id])
    @cart = current_cart
    @cart_item = @cart.cart_items.find_or_initialize_by(book_id: book.id)

    if @cart_item.new_record?
      @cart_item.quantity = 1
    else
      @cart_item.quantity += 1
    end


    if @cart_item.save
      redirect_to books_path, notice: 'Book added to cart.'
    else
      redirect_to books_path, alert: 'Unable to add book to cart.'
    end
  end



  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:quantity].to_i)
    redirect_to books_path, notice: 'Quantity updated successfully!'
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to books_path, notice: 'Book removed from cart.'
  end
  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
