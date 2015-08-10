require 'spec_helper'

describe Country do
	it "Allows build a new Country model" do
		expect(FactoryGirl.build(:country_mexico)).to be_valid
	end

	it "Is invalid without name" do
		country = FactoryGirl.build(:country)
		expect(country).to have(1).errors_on(:name)
	end

	it "Is invalid with duplicate name" do
		FactoryGirl.create(:country_mexico)
		country = FactoryGirl.build(:country_mexico)
		expect(country).to have(1).errors_on(:name)
	end

	it "Is invalid to delete a country with states" do
		country = FactoryGirl.create(:country_mexico)
		state   = country.states.create(name: 'JALISCO')
		expect {country.destroy}.to raise_exception
	end

	it "Is valid to delete a country without states" do
		country = FactoryGirl.create(:country_mexico)
		expect {country.destroy}.to_not raise_exception
	end
end
