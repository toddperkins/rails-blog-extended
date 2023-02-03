FactoryBot.define do
  factory :article do
    title         { Faker::Fantasy::Tolkien.poem }
    body          { Faker::Lorem.paragraph(sentence_count: 5) }
    created_at    { Time.now }
    updated_at    { Time.now }
  end
end