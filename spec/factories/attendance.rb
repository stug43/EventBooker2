FactoryBot.define do
  factory :attendance do
   	stripe_customer_id { Faker::Pokemon.name }    
		event { Event.all.sample }
		attendee { User.all.sample }
  end
end
