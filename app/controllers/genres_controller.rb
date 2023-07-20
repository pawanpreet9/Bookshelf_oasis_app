class GenresController < ApplicationController
  def index
    @genres = Genre.page(params[:page]).per(10)
  end
  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end
end
