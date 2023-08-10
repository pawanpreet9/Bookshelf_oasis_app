# frozen_string_literal: true

class GenresController < ApplicationController
  def index
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Genres', genres_path
    @genres = Genre.page(params[:page]).per(10)
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end
end
