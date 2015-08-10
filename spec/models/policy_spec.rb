require 'spec_helper'

describe Policy do
  it "Allows build a new Policy model" do
  	expect(FactoryGirl.build(:policy_chartis)).to be_valid
  end

  it "Is invalid without a Folio" do
  	policy = FactoryGirl.build(:policy_chartis, folio: nil)
  	expect(policy).to have(1).errors_on(:folio)
  end

  it "Is invalid with a duplicate folio" do
  	FactoryGirl.create(:policy_chartis)
  	policy = FactoryGirl.build(:policy_orbe)
  	expect(policy).to have(1).errors_on(:folio)
  end

  it "Is invalid without Moneda" do
  	policy = FactoryGirl.build(:policy_chartis, moneda: nil)
  	expect(policy).to have(1).errors_on(:moneda)
  end

  it "Is invalid without an Insurance" do
    policy = FactoryGirl.build(:policy)
    expect(policy).to have(1).errors_on(:insurance_id)
  end

  it "Is invalid without date_start" do
    policy = FactoryGirl.build(:policy_chartis, date_start: nil)
    expect(policy).to have(1).errors_on(:date_start)
  end

  it "Is invalid without date_end" do
    policy = FactoryGirl.build(:policy_chartis, date_end: nil)
    expect(policy).to have(1).errors_on(:date_end)
  end

  it "Is invalid with date_start greater than date_end" do
    policy = FactoryGirl.build(:policy_chartis, date_start: Date.current() + 1, date_end: Date.current() - 1)
    expect(policy).to have(1).errors_on(:date_start)
  end

  it "Is invalid with date_start into range of another policy" do
    insurance = FactoryGirl.create(:insurance_chartis)
    FactoryGirl.create(:policy, insurance_id: insurance.id)
    policy = FactoryGirl.build(:policy, date_start: Date.current(), date_end: Date.current() + 30, insurance_id: insurance.id)
    expect(policy).to have(1).errors_on(:date_start)
  end

  it "Is invalid with date_end into range of another policy" do
    insurance = FactoryGirl.create(:insurance_chartis)
    FactoryGirl.create(:policy, insurance_id: insurance.id)
    policy = FactoryGirl.build(:policy, date_start: Date.current() - 30, date_end: Date.current(), insurance_id: insurance.id)
    expect(policy).to have(1).errors_on(:date_end)
  end

  it "Is invalid with policy range over another policy" do
    insurance = FactoryGirl.create(:insurance_chartis)
    FactoryGirl.create(:policy, insurance_id: insurance.id)
    policy = FactoryGirl.build(:policy, folio: "XXX", date_start: Date.current() - 2, date_end: Date.current() + 2, insurance_id: insurance.id)
    expect(policy).to have(1).errors_on(:date_start)
  end
end
