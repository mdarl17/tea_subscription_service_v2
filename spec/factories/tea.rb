FactoryBot.define do
	factory :tea do
		title { Faker::Tea.variety }
		description { Faker::Tea.variety(type: ["Green", "Black", "White", "Herbal"].sample) + ["Lorem", "ipsum", "danang", "Oolong", "Yunnan"].shuffle.join(" ")}
		temperature { Faker::Number.between(from: 40, to: 100) }
		brew_time { Faker::Number.between(from: 4, to: 10) }
	end
end