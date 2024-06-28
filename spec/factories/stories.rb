FactoryBot.define do
  factory :story do
    title { "Wow V. Cool" }
    url { "www.wow.cool" }
    source_id { 1234567890 }
    hacker_news
  end

  factory :top_story, parent: :story do
    is_top_story { true }
  end
end
