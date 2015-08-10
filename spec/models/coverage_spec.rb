require 'spec_helper'

describe Coverage do
	it "Allows build a new Coverage model" do
		expect(FactoryGirl.build(:coverage_riesgo)).to be_valid
	end

	it "Is invalid without a name" do
		coverage = FactoryGirl.build(:coverage_riesgo, name: nil)
		expect(coverage).to have(1).errors_on(:name)
	end

	it "Is invalid with a duplicate name" do
		FactoryGirl.create(:coverage_riesgo)
		coverage = FactoryGirl.build(:coverage_riesgo)
		expect(coverage).to have(1).errors_on(:name)
	end

	it "Is invalid without deductible_min" do
		coverage = FactoryGirl.build(:coverage_riesgo, deductible_min: nil)
		expect(coverage).to have(2).errors_on(:deductible_min)  # 2 errores: por nulo y por no numerico
	end

	it "Is invalid with deductible_min equal to 0" do
		coverage = FactoryGirl.build(:coverage_riesgo, deductible_min: 0)
		expect(coverage).to have(1).errors_on(:deductible_min)
	end

	it "Is invalid with deductible_min equal to 100" do
		coverage = FactoryGirl.build(:coverage_riesgo, deductible_min: 100)
		expect(coverage).to have(1).errors_on(:deductible_min)
	end

	it "Is invalid with deductible_min greater than 100" do
		coverage = FactoryGirl.build(:coverage_riesgo, deductible_min: 101)
		expect(coverage).to have(1).errors_on(:deductible_min)
	end 
end
