# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certificate_request_clause do
    is_included true

    factory :clause_req_bodega do
      after(:build) do |crb|
        crb.clause = FactoryGirl.create(:clause_bodega)
      end
    end

  end
end
