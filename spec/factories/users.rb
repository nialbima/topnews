FactoryBot.define do
  factory :user do
    first_name { p }
    email { "MyString" }
    last_name { "MyString" }
  end

  factory :valid_user, parent: :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { "foobar123" }
  end
end
