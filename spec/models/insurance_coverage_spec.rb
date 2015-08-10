require 'spec_helper'

describe InsuranceCoverage do
  it "Allows build a new InsuranceCoverage model" do
    expect(FactoryGirl.build(:insurance_coverage_first)).to be_valid
  end

  it "Is invalid without deductible_min" do
    record = FactoryGirl.build(:insurance_coverage_first, deductible_min: nil)
    expect(record).to have_at_least(1).errors_on(:deductible_min)
  end

  it "Is invalid with deductible_min equals 0" do
    record = FactoryGirl.build(:insurance_coverage_first, deductible_min: 0)
    expect(record).to have_at_least(1).errors_on(:deductible_min)
  end

  it "Is invalid with deductible_min greater than 100" do
    record = FactoryGirl.build(:insurance_coverage_first, deductible_min: 101)
    expect(record).to have_at_least(1).errors_on(:deductible_min)
  end

  it "Is invalid without insurance_id" do
    record = FactoryGirl.build(:insurance_coverage)
    expect(record).to have_at_least(1).errors_on(:insurance_id)
  end

  it "Is invalid without coverage_id" do
    record = FactoryGirl.build(:insurance_coverage)
    expect(record).to have_at_least(1).errors_on(:coverage_id)
  end
end
