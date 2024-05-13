class Customer < ApplicationRecord
	has_many :subscriptions
	has_many :teas, through: :subscriptions

	validates :first_name, :last_name, :address, :api_key, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end