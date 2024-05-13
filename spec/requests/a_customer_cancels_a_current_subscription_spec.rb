require "rails_helper"

RSpec.describe "Customer Tea Subscriptions", type: :request do
	before(:each) do 
		@customer = create(:customer)
		@teas = create_list(:tea, 5)

		5.times do |n|
			Subscription.create!(
				customer_id: @customer.id,
				tea_id: @teas[n].id,
				frequency: (0..2).to_a.sample,
				status: 0
			)
		end
	end

	it "a customer can cancel a tea subscription" do
		cxl_sub = Subscription.all.sample

		expect(cxl_sub.status).to eq("active")

		patch "/api/v0/customers/:customer_id/subscriptions/:id",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json"},
			params: { tea_id: cxl_sub.tea_id, customer_id: cxl_sub.customer_id }.to_json

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(200)
		expect(parsed.keys).to eq([:data])
		expect(parsed[:data]).to be_a Hash
		expect(parsed[:data].keys).to match_array([:id, :type, :attributes])
		expect(parsed[:data][:id]).to be_a String
		expect(parsed[:data][:id]).to eq(cxl_sub.id.to_s)
		expect(parsed[:data][:type]).to be_a String
		expect(parsed[:data][:type]).to eq("subscription")
		expect(parsed[:data][:attributes]).to be_a Hash
		expect(parsed[:data][:attributes].keys).to match_array([:id, :customer_id, :tea_id, :frequency, :status])
		expect(parsed[:data][:attributes][:id]).to eq(cxl_sub.id)
		expect(parsed[:data][:attributes][:customer_id]).to eq(cxl_sub.customer_id)
		expect(parsed[:data][:attributes][:tea_id]).to eq(cxl_sub.tea_id)
		expect(parsed[:data][:attributes][:frequency]).to eq(cxl_sub.frequency)
		expect(parsed[:data][:attributes][:status]).to eq("cancelled")
	end

	it "returns an error if a subscription can't be found" do
		cxl_sub = Subscription.all.sample

		expect(cxl_sub.status).to eq("active")

		patch "/api/v0/customers/:customer_id/subscriptions/:id",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json"},
			params: { tea_id: 332131, customer_id: cxl_sub.customer_id }.to_json
	
		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(404)
		expect(parsed).to eq({:error=>"Subscription not found"})
	end

	it "returns an error if a subscription can't be found" do
		cxl_sub = Subscription.all.sample

		expect(cxl_sub.status).to eq("active")

		patch "/api/v0/customers/:customer_id/subscriptions/:id",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json"},
			params: { tea_id: cxl_sub.tea_id, customer_id: 2321232}.to_json
	
		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(404)
		expect(parsed).to eq({:error=>"Subscription not found"})
	end
end