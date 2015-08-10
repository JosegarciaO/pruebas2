# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :insurance_coverage do
    deductible_min "9.99"

    factory :insurance_coverage_first do
      after(:build) do |p|
        p.insurance = FactoryGirl.create(:insurance_chartis)
        p.coverage = FactoryGirl.create(:coverage_riesgo)
      end
    end

  end
end
