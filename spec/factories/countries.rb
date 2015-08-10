# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    
  	factory :country_mexico do
  		name "MEXICO"
  	end

  	factory :country_usa do
  		name "ESTADOS UNIDOS"
  	end

  	factory :country_canada do
  		name "CANADA"
  	end

  end
end
