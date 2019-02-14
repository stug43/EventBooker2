FactoryBot.define do
  factory :event do
    start_date { Faker::Date.forward(23) }
    title { Faker::Zelda.game }
    duration { Faker::Number.number(3) }
		description { Faker::Lorem.words(50) }
		location { Faker::Nation.capital_city }
		price { Faker::Number.number(2)%1000 }    
		admin { User.all.sample }
  end
end
