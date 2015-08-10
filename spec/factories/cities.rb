# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do

    factory :city_guadalajara do
        name "GUADALAJARA"
    	after(:build) do |city|
    		city.state = FactoryGirl.create(:state_jalisco)
    	end
    end

    factory :city_miami do
        name "MIAMI"
    	after(:build) do |city|
    		city.state = FactoryGirl.create(:state_florida)
    	end
    end

    factory :city_toronto do
        name "TORONTO"
        after(:build) do |city|
            city.state = FactoryGirl.create(:state_ontario)
        end
    end
  end
end
