require 'spec_helper'

describe Possession do
	it "Allows build a new Possession model" do
		expect(FactoryGirl.build(:possession_metales)).to be_valid
	end

	it "Is invalid without a name" do
		possession = FactoryGirl.build(:possession)
		expect(possession).to have(1).errors_on(:name)
	end

	it "Is invalid with a duplicate name" do
		FactoryGirl.create(:possession_metales)
		possession = FactoryGirl.build(:possession_metales)
		expect(possession).to have(1).errors_on(:name)
	end

	it "Is invalid without max_amount" do
		possession = FactoryGirl.build(:possession_metales, max_amount: nil)
		expect(possession).to have_at_least(1).errors_on(:max_amount)
	end

	it "Is invalid with has_max_amount and max_amount = 0" do
		possession = FactoryGirl.build(:possession_metales, max_amount: 0)
		expect(possession).to have_at_least(1).errors_on(:max_amount)
	end
end
