require "rails_helper"

RSpec.describe "Customer Tea Subscriptions", type: :request do
	before(:each) do 
		@customer = create(:customer)
		@teas = create_list(:tea, 10)

		10.times do |n|
			Subscription.create!(
				customer_id: @customer.id,
				tea_id: @teas[n].id,
				frequency: (0..2).to_a.sample,
				status: (0..1).to_a.sample
			)
		end
	end
	
	it "returns all active and cancelled customer subscriptions" do 
		get "/api/v0/customers/:customer_id/subscriptions",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(200)
		expect(parsed).to be_an Array
		expect(parsed.length).to eq(10)
		expect(parsed.first.keys).to eq([:data])
		expect(parsed.first[:data]).to be_a Hash
		expect(parsed.first[:data].keys).to match_array([:id, :type, :attributes])
		expect(parsed.first[:data][:id]).to be_a String
		expect(parsed.first[:data][:id]).to eq(Subscription.all.first.id.to_s)
		expect(parsed.first[:data][:type]).to be_a String
		expect(parsed.first[:data][:type]).to eq("subscription")
		expect(parsed.first[:data][:attributes]).to be_a Hash
		expect(parsed.first[:data][:attributes].keys).to match_array([:id, :customer_id, :tea_id, :frequency, :status])
		expect(parsed.first[:data][:attributes][:id]).to eq(Subscription.all.first.id)
		expect(parsed.first[:data][:attributes][:customer_id]).to eq(Subscription.all.first.customer_id)
		expect(parsed.first[:data][:attributes][:tea_id]).to eq(Subscription.all.first.tea_id)
		expect(parsed.first[:data][:attributes][:frequency]).to eq(Subscription.all.first.frequency)
		expect(parsed.first[:data][:attributes][:status]).to eq(Subscription.all.first.status)
	end
end