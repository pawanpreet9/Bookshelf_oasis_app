class CreateJoinTableGenreBook < ActiveRecord::Migration[7.0]
  def change
    create_join_table :genres, :books do |t|
      t.index [:genre_id, :book_id]
       t.index [:book_id, :genre_id]
    end
  end
end
