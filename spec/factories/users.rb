FactoryGirl.define do
  factory :todo do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end