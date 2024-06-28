FactoryBot.define do
  factory :flag do
    association :user
    association :story
  end
end
