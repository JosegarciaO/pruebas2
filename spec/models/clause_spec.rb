require 'spec_helper'

describe Clause do
  it "Allows build a new Clause model" do
    expect(FactoryGirl.build(:coverage_riesgo)).to be_valid
  end

  it "Is invalid without a name" do
    clause = FactoryGirl.build(:clause_bodega, name: nil)
    expect(clause).to have(1).errors_on(:name)
  end

  it "Is invalid with a duplicate name" do
    FactoryGirl.create(:clause_bodega)
    clause = FactoryGirl.build(:clause_bodega)
    expect(clause).to have(1).errors_on(:name)
  end

end
