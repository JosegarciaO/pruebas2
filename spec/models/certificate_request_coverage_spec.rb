require 'spec_helper'

describe CertificateRequestCoverage do
	it "Allows build a new CertificateRequestCoverage model" do
		expect(FactoryGirl.build(:cert_req_robo_total)).to be_valid
	end

	it "Is invalid without coverage_id" do
		rec = FactoryGirl.build(:certificate_request_coverage)
		expect(rec).to have_at_least(1).errors_on(:coverage_id)
	end

	it "Is invalid without deductible" do
		rec = FactoryGirl.build(:cert_req_robo_total, deductible: nil)
		expect(rec).to have_at_least(1).errors_on(:deductible)
	end

	it "Is invalid with deductible greater than 100" do
		rec = FactoryGirl.build(:cert_req_robo_total, deductible: 100)
		expect(rec).to have_at_least(1).errors_on(:deductible)
	end

	it "Is invalid with deductible less than minimum" do
		rec = FactoryGirl.build(:cert_req_robo_total, deductible: 15)
		expect(rec).to have_at_least(1).errors_on(:base)
	end

end
