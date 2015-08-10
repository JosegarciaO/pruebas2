require 'spec_helper'

describe Transportation do
  it "Allows build a new Transportation model" do
    expect(FactoryGirl.build(:transportation)).to be_valid
  end

  it "Is invalid without a name" do
    transportation = Transportation.new
    expect(transportation).to have(1).errors_on(:name)
  end

  it "Is invalid with duplicate name" do
    FactoryGirl.create(:transportation)
    transportation = FactoryGirl.build(:transportation)
    expect(transportation).to have(1).errors_on(:name)
  end
end
