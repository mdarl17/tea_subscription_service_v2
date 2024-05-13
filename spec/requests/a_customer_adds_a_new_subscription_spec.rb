require "rails_helper"

RSpec.describe "Customer Tea Subscriptions", type: :request do
	before(:each) do 
		@customer = create(:customer)
		@teas = create_list(:tea, 5)
		@frequency = (0..2).to_a.sample
		@status = (0..1).to_a.sample
	end

	# create new subscription - happy path
	it "creates a new subscription for a customer" do
		request_body = {
			customer_id: @customer.id,
			tea_id: @teas.sample.id,
			frequency: @frequency,
			status: 0
		}.to_json

		post "/api/v0/customers/:customer_id/subscriptions",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: request_body

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(200)
		expect(parsed.keys).to eq([:data])
		expect(parsed[:data]).to be_a Hash
		expect(parsed[:data].keys).to match_array([:id, :type, :attributes])
		expect(parsed[:data][:id]).to be_a String
		expect(parsed[:data][:id]).to eq(Subscription.last.id.to_s)
		expect(parsed[:data][:type]).to be_a String
		expect(parsed[:data][:type]).to eq("subscription")
		expect(parsed[:data][:attributes]).to be_a Hash
		expect(parsed[:data][:attributes].keys).to match_array([:id, :customer_id, :tea_id, :frequency, :status])
		expect(parsed[:data][:attributes][:id]).to eq(Subscription.last.id)
		expect(parsed[:data][:attributes][:customer_id]).to eq(Subscription.last.customer_id)
		expect(parsed[:data][:attributes][:tea_id]).to eq(Subscription.last.tea_id)
		expect(parsed[:data][:attributes][:frequency]).to eq(Subscription.last.frequency)
		expect(parsed[:data][:attributes][:status]).to eq(Subscription.last.status)
	end

	# create new subscription - sad path
		# missing frequency data
	it "returns an error if a value for frequency is not provided" do
		request_body = {
			customer_id: @customer.id,
			tea_id: @teas.sample.id,
			status: 0
		}.to_json

		post "/api/v0/customers/:customer_id/subscriptions",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: request_body

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(422)
		expect(parsed.join(", ")).to eq("Frequency can't be blank, Frequency is not a number")
	end

	# create new subscription - sad path
		# missing status data
	it "returns an error if a value for frequency is not provided" do
		request_body = {
			customer_id: @customer.id,
			tea_id: @teas.sample.id,
			frequency: @frequency
		}.to_json

		post "/api/v0/customers/:customer_id/subscriptions",
			headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
			params: request_body

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response.status).to eq(422)
		expect(parsed.join(", ")).to eq("Status can't be blank, Status is not a number")
	end


	# create new subscription - sad path
		# missing status and frequency data
		it "returns an error if a value for frequency is not provided" do
			request_body = {
				customer_id: @customer.id,
				tea_id: @teas.sample.id
			}.to_json
	
			post "/api/v0/customers/:customer_id/subscriptions",
				headers: { "Content-Type" => "application/json", "Accept" => "application/json" },
				params: request_body
	
			parsed = JSON.parse(response.body, symbolize_names: true)
	
			expect(response.status).to eq(422)
			expect(parsed.join(", ")).to eq("Status can't be blank, Frequency can't be blank, Status is not a number, Frequency is not a number")
		end
end 