# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :policy do
    folio "P-00001"
    moneda "M"
    date_start  Date.current() - 1
    date_end    Date.current() + 1
    
    factory :policy_chartis do
    	after(:build) do |p|
    		p.insurance = FactoryGirl.create(:insurance_chartis)
    	end
    end

    factory :policy_orbe do
    	after(:build) do |p|
    		p.insurance = FactoryGirl.create(:insurance_orbe)
    	end
    end

  end
end
