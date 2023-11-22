FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Code.isbn(base: 13) }
    description { Faker::Lorem.paragraph }
  end

  trait :empty_title do
    title { "" }
  end

  trait :new_title do
    title { "New Title" }
  end

  trait :with_attached_cover do
    cover { Rack::Test::UploadedFile.new("spec/support/files/cover_placeholder.png", "image/jpeg") }
  end

  trait :with_attached_content do
    content { Rack::Test::UploadedFile.new("spec/support/files/Lorem_ipsum.pdf", "application/pdf") }
  end
end
