class Subscription < ApplicationRecord
	belongs_to :customer
	belongs_to :tea

	validates :status, :frequency, presence: true

	enum status: {"active": 0, "cancelled": 1}
	enum frequency: {"weekly": 0, "monthly": 1, "quarterly": 2}
end