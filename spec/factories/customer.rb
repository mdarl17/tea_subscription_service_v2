FactoryBot.define do
	factory :customer do
		first_name { Faker::Name.first_name }
		last_name { Faker::Name.last_name }
		email { Faker::Internet.email(domain: 'gmail.com') }
		address { Faker::Address.full_address }
		api_key { SecureRandom.alphanumeric }
	end
end