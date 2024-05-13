class Api::V0::CustomerTeasController < ApplicationController
	def create
		subscription = Subscription.new(customer_tea_params)
		if subscription.save
			render json: SubscriptionSerializer.new(subscription), status: :ok
		else
			render json: subscription.errors.full_messages, status: :unprocessable_entity
		end
	end

	private

	def customer_tea_params
		params.require(:customer_tea).permit(:customer_id, :tea_id, :frequency, :status)
	end
end