require "faker"

20.times do
  book = Book.new(
  title: Faker::Book.title,
  author: Faker::Book.author,
  isbn: Faker::Code.isbn(base: 13),
  description: "#{Faker::Book.genre}, #{Faker::Book.publisher}"
  )

  book.save
end
