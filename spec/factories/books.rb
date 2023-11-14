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
    after(:create) do |book|
      book.cover.attach(
        io: File.open(Rails.root.join("spec", "factories", "attachments", "cover_placeholder.png")),
                      filename: "cover_placeholder.png",
                      content_type: "image/png"
      )
    end
  end

  trait :with_attached_content do
    after(:create) do |book|
      book.content.attach(
        io: File.open(Rails.root.join("spec", "factories", "attachments", "Lorem_ipsum.pdf")),
                      filename: "Lorem_ipsum.pdf",
                      content_type: "application/pdf"
      )
    end
  end
end
