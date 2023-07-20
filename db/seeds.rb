# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'
require 'faker'

genres = []
20.times do
  genre = Genre.new(name: Faker::Book.unique.genre)
  if(genre.save)


    puts "successfully saved"


else
  puts "error"
end
end



# Import authors from CSV
# Import authors from CSV
csv_path = Rails.root.join('db', 'authors.csv')
if File.exist?(csv_path)
  CSV.foreach(csv_path, headers: true) do |row|
    Author.create!(name: row['author_name'])
    break if Author.count >= 105
  end
else
  puts "The authors.csv file does not exist in the db folder."
end
# Get all genre and author IDs
author_ids = Author.pluck(:id)
genre_ids = Genre.pluck(:id)
#book.genres << genres
#genre_ids = Genre.pluck(:id)
# Create 100 books with random genre and author associations
100.times do
 book = Book.new(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph,
    quantity: rand(1..100),
    pages: rand(50..500),
    price: rand(5.0..50.0).round(2),
    publisher: Faker::Book.publisher,
    publication_date: Faker::Date.between(from: 50.years.ago, to: Date.today),
    author_id: author_ids.sample,


  )

# Assign unique genres to the book
genre_ids = Genre.pluck(:id).sample(rand(1..3))
genres = Genre.where(id: genre_ids)
book.genres << genres

  book.image.attach(io: URI.open(Faker::LoremFlickr.image(size: "300x400")), filename: "#{book.title.parameterize}.jpg")

  if  book.save


    puts "Successfully saved book: #{book.title}"
  else
    puts "Error saving book: #{book.errors.full_messages.join(', ')}"
  end
end