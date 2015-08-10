require 'spec_helper'

describe Role do
	it "Allows build a new Role model" do
		expect(FactoryGirl.build(:role)).to be_valid
	end

	it "Is invalid without a name" do
		role = FactoryGirl.build(:role, name: nil)
		expect(role).to have(1).errors_on(:name)
	end

	it "Is invalid with duplicate name" do
		FactoryGirl.create(:role)
		role = FactoryGirl.build(:role)
		expect(role).to have(1).errors_on(:name)
	end

	it "Is invalid without a permalink" do
		role = FactoryGirl.build(:role, permalink: nil)
		expect(role).to have(1).errors_on(:permalink)
	end

	it "Is invalid with duplicate permalink" do
		FactoryGirl.create(:role)
		role = FactoryGirl.build(:role)
		expect(role).to have(1).errors_on(:permalink)
	end

end
