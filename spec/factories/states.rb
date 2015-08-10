# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do

    factory :state_jalisco do
        name "JALISCO"
    	after(:build) do |state|
            state.country = FactoryGirl.create(:country_mexico)
        end
    end

    factory :state_florida do
        name "FLORIDA"
    	after(:build) do |state|
            state.country = FactoryGirl.create(:country_usa)
        end
    end

    factory :state_ontario do
        name "ONTARIO"
    	after(:build) do |state|
            state.country = FactoryGirl.create(:country_canada)
        end
    end
  end
end
