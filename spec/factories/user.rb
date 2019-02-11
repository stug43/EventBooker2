FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name + "   " }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
		description { Faker::Lorem.words(25) }    
  end
end
