# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :possession do
    
  	factory :possession_metales do
  		name "METALES PRECIOSOS"
  		active true
  		has_max_amount true
  		max_amount 4000000
  	end

  	factory :possession_metales_no do
  		name "METALES NO PRECIOSOS"
  		active false
  		has_max_amount false
  		max_amount 0
  	end

  end
end
