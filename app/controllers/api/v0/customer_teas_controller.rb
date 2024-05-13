class Api::V0::CustomerTeasController < ApplicationController
	def create
		subscription = Subscription.new(customer_tea_params)
		if subscription.save
			render json: SubscriptionSerializer.new(subscription), status: :ok
		else
			render json: subscription.errors.full_messages, status: :unprocessable_entity
		end
	end

	def update
		subscription = Subscription.find_by(customer_id: params[:customer_tea][:customer_id], tea_id: params[:customer_tea][:tea_id])
		if subscription && subscription.update(status: 1)
			render json: SubscriptionSerializer.new(subscription), status: :ok
		else
			render json: { error: "Subscription not found" }, status: :not_found
		end
	end

	private

	def customer_tea_params
		params.require(:customer_tea).permit(:customer_id, :tea_id, :frequency, :status)
	end
end