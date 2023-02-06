FactoryBot.define do
  factory :article do
    title         { Faker::Fantasy::Tolkien.poem }
    body          { Faker::Lorem.paragraph(sentence_count: 5) }
    created_at    { Time.now }
    updated_at    { Time.now }

    trait :with_comments do
      after(:create) do |instance|
        create_list :comment, 2, article: instance
      end
    end
  end

  factory :comment do
    article
    commenter     { Faker::Name.name }
    body          { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end