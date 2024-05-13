require "rails_helper"

RSpec.describe Subscription, type: :model do 
	describe "validations" do 
		it { should validate_presence_of(:frequency) }
		it { should validate_presence_of(:status) }
	end

	describe "relationships" do
		it { should belong_to(:customer) }
		it { should belong_to(:tea) }
	end
end 