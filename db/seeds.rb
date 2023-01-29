# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# begin
puts 'Seeding...'

# create article & comments
rand(2..15).times do
  
  # article
  article = Article.create(
    title: Faker::Fantasy::Tolkien.poem,
    body: Faker::Lorem.paragraph(sentence_count: 5)
  )

  # comments
  rand(2..8).times do
    comment = Comment.create(
      article_id: article.id,
      commenter: Faker::Fantasy::Tolkien.character,
      body: Faker::Lorem.paragraph(sentence_count: 2)
    )
  end

end

# end
puts 'Done seeding...'