require 'spec_helper'

describe City do
	it "Allows build a new City model" do
		expect(FactoryGirl.build(:city_guadalajara)).to be_valid
	end

	it "Is invalid without a name" do
		city = FactoryGirl.build(:city_guadalajara, name: nil)
		expect(city).to have(1).errors_on(:name)
	end

	it "Is invalid without a State" do
		city = FactoryGirl.build(:city)
		expect(city).to have(1).errors_on(:state_id)
	end

	it "Is invalid with duplicate name on the same State" do
		state = FactoryGirl.create(:state_jalisco)
		city1 = state.cities.create(name: "GUADALAJARA")
		city2 = state.cities.build(name: "GUADALAJARA")
		expect(city2).to have(1).errors_on(:name)
	end

	it "Is valid with duplicate name on different States" do
		country = FactoryGirl.create(:country_mexico)
		jalisco = FactoryGirl.create(:state, name:'JALISCO', country_id:country.id)
		sinaloa = FactoryGirl.create(:state, name:'SINALOA', country_id:country.id)

		FactoryGirl.create(:city, name:'GUADALAJARA', state_id: jalisco.id)
		city = FactoryGirl.build(:city, name:'GUADALAJARA', state_id: sinaloa.id)
		expect(city).to be_valid
	end

	it "Is invalid to delete a City with Certificate Requests" do
		req = FactoryGirl.create(:cualsi_request)
		expect {req.city.destroy}.to raise_exception
	end 

	it "Is valid to delete a City without Certificate Requests" do
		city = FactoryGirl.create(:city_guadalajara)
		expect {city.destroy}.to_not raise_exception
	end
end
