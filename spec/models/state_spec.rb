require 'spec_helper'

describe State do
	it "Allows build a new State model" do
		expect(FactoryGirl.build(:state_jalisco)).to be_valid
	end

	it "Is invalid without a name" do
		state = FactoryGirl.build(:state)
		expect(state).to have(1).errors_on(:name)
	end

	it "Is invalid with duplicate name" do
		FactoryGirl.create(:state_jalisco)
		state = FactoryGirl.build(:state_florida, name: 'JALISCO')
		expect(state).to have(1).errors_on(:name)
	end

	it "Is invalid without a Country" do
		state = FactoryGirl.build(:state, country_id: nil)
		expect(state).to have(1).errors_on(:country_id)
	end

	it "Is invalid to delete a state with cities" do
		state = FactoryGirl.create(:state_jalisco)
		city  = state.cities.create(name: 'GUADALAJARA')
		expect {state.destroy}.to raise_exception
	end

	it "Is valid to delete a state without cities" do
		state = FactoryGirl.create(:state_jalisco)
		expect {state.destroy}.to_not raise_exception
	end
end
