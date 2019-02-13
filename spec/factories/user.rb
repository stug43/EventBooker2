FactoryBot.define do
  factory :user do
	current_password	= Faker::Internet.password(8)
    first_name { Faker::Name.first_name + "   " }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
		description { Faker::Lorem.words(25) }    
		password { current_password }
		password_confirmation { current_password }
	end
end
