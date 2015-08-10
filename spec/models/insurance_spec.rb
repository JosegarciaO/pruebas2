require 'spec_helper'

describe Insurance do
	it "Allows build a new Insurance model" do
  		expect(FactoryGirl.build(:insurance_chartis)).to be_valid
  	end

	it "Is invalid without a name" do
		insurance = FactoryGirl.build(:insurance)
		expect(insurance).to have(1).errors_on(:name)
	end

	it "Is invalid with a duplicate name" do
		FactoryGirl.create(:insurance_chartis)
		insurance = FactoryGirl.build(:insurance_chartis)
		expect(insurance).to have(1).errors_on(:name)
	end

	it "Is invalid to delete an Insurance with Policies" do
		insurance = FactoryGirl.create(:policy_chartis).insurance
		expect {insurance.destroy}.to raise_exception
	end

	it "Is valid to delete an Insurance without Policies" do
		insurance = FactoryGirl.create(:insurance_chartis)
		expect {insurance.destroy}.to_not raise_exception
	end

	it "Is invalid without expedition_fee_mx" do
		insurance = FactoryGirl.build(:insurance_chartis, expedition_fee_mx: nil)
		expect(insurance).to have_at_least(1).errors_on(:expedition_fee_mx)
	end

	it "Is invalid without expedition_fee_us" do
		insurance = FactoryGirl.build(:insurance_chartis, expedition_fee_us: nil)
		expect(insurance).to have_at_least(1).errors_on(:expedition_fee_us)
	end

	it "Is invalid with expedition_fee_mx equals to 0" do
		insurance = FactoryGirl.build(:insurance_chartis, expedition_fee_mx: 0)
		expect(insurance).to have_at_least(1).errors_on(:expedition_fee_mx)
	end

	it "Is invalid with expedition_fee_us equals to 0" do
		insurance = FactoryGirl.build(:insurance_chartis, expedition_fee_us: 0)
		expect(insurance).to have_at_least(1).errors_on(:expedition_fee_us)
	end

	it "Is invalid without max_amount" do
		insurance = FactoryGirl.build(:insurance_chartis, max_amount: nil)
		expect(insurance).to have_at_least(1).errors_on(:max_amount)
	end

	it "Is invalid with max_amount equals to 0" do
		insurance = FactoryGirl.build(:insurance_chartis, max_amount: 0)
		expect(insurance).to have_at_least(1).errors_on(:max_amount)
	end

	
end
