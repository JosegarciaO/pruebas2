require 'spec_helper'

describe CertificateRequestClause do
  it "Allows build a new CertificateRequestClause model" do
    expect(FactoryGirl.build(:clause_req_bodega)).to be_valid
  end

  it "Is invalid without clause_id" do
    rec = FactoryGirl.build(:certificate_request_clause)
    expect(rec).to have_at_least(1).errors_on(:clause_id)
  end

end
