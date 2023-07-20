class BooksController < ApplicationController
  def index
    @books = Book.includes(:author, :genres).page(params[:page]).per(10)
  end
  def show
    @book = Book.includes(:author, :genres).find(params[:id])
  end
end
