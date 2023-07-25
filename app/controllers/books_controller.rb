class BooksController < ApplicationController
  def index
    @books = Book.includes(:author, :genres).page(params[:page]).per(10)
    @cart = current_cart
  if params[:keyword].present?
  @books = @books.where('title LIKE ?', "%#{params[:keyword]}%")
end
if params[:genre_id].present?
  @books = @books.joins(:genres).where(genres: { id: params[:genre_id] })
end
end

  def show
    @book = Book.includes(:author, :genres).find(params[:id])

  end
  def books_on_sale
    @books = Book.includes(:author, :genres).page(params[:page]).per(10)
    @books_on_sale = Book.includes(:author, :genres).where('price < ?', 20).page(params[:page]).per(10)
  end
  def new_books
    @new_books = Book.includes(:author, :genres).where('created_at >= ?', 3.days.ago).page(params[:page]).per(10)
  end
  def recently_updated_books
    @recently_updated_books = Book.includes(:author, :genres).where('updated_at >= ?', 3.days.ago).page(params[:page]).per(10)
    @recently_updated_books = @recently_updated_books.where.not('created_at >= ?', 3.days.ago)
  end
end
