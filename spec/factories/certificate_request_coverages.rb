# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certificate_request_coverage do
    incluir true
    deductible 20  # debe ser <= al minimo en coverages

    factory :cert_req_robo_total do
      after(:build) do |crq|
        crq.coverage = FactoryGirl.create(:coverage_robo)
      end
    end

  end
end
