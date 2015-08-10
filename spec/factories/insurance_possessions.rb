# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :insurance_possession do
    has_max_amount false
    max_amount "9.99"

    factory :insurance_possession_first do
      after(:build) do |p|
        p.insurance = FactoryGirl.create(:insurance_chartis)
        p.possession = FactoryGirl.create(:possession_metales)
      end
    end

    factory :insurance_possession_second do
      after(:build) do |p|
        p.insurance = FactoryGirl.create(:insurance_orbe)
        p.possession = FactoryGirl.create(:possession_metales_no)
      end
    end

  end
end
