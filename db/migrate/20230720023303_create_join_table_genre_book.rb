# frozen_string_literal: true

# Create Join table for genre and book.
class CreateJoinTableGenreBook < ActiveRecord::Migration[7.0]
  def change
    # migration code here
    create_join_table :genres, :books do |t|
      t.index %i[genre_id book_id]
      t.index %i[book_id genre_id]
    end
  end
end
