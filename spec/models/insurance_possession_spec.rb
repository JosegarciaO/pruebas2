require 'spec_helper'

describe InsurancePossession do
  it "Allows build a new InsurancePossession model" do
    expect(FactoryGirl.build(:insurance_possession_first)).to be_valid
  end

  it "Is invalid without max_amount" do
    record = FactoryGirl.build(:insurance_possession, max_amount: nil)
    expect(record).to have_at_least(1).errors_on(:max_amount)
  end

  it "Is invalid with max_amount equals 0" do
    record = FactoryGirl.build(:insurance_possession, max_amount: 0)
    expect(record).to have_at_least(1).errors_on(:max_amount)
  end

  it "Is invalid without insurance_id" do
    record = FactoryGirl.build(:insurance_possession)
    expect(record).to have_at_least(1).errors_on(:insurance_id)
  end

  it "Is invalid without possession_id" do
    record = FactoryGirl.build(:insurance_possession)
    expect(record).to have_at_least(1).errors_on(:possession_id)
  end

end
