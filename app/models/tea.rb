class Tea < ApplicationRecord
	has_many :subscriptions
	has_many :customers, through: :subscriptions

	validates :title, :description, presence: true
	validates :temperature, :brew_time, presence: true, numericality: { only_integer: true }
end