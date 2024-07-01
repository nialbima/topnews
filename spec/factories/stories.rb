FactoryBot.define do
  factory :story do
    title { "Wow V. Cool" }
    url { "www.wow.cool" }
    source_id { 87654321 }
    rank { nil }

    trait :randomized do
      source_id { rand(1e7...1e8).to_i }
    end
    trait :ranked do
      sequence(:rank) { |n| n }
    end

    trait :is_top_story  do
      is_top_story { true }
    end
  end

  factory :top_story, traits: [:ranked, :randomized, :is_top_story], parent: :story
end
