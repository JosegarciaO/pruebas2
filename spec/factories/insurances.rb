# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :insurance do

		factory :insurance_chartis do
	    	name "CHARTIS"
	    	expedition_fee_mx 250
	    	expedition_fee_us 25
	    	max_amount 4000000
	    	deductible_text "Texto default de deducible"
	    end

	    factory :insurance_orbe do
	    	name "ORBE"
	    	expedition_fee_mx 220
	    	expedition_fee_us 22
	    	max_amount 3000000
	    	deductible_text nil
	    end

	end
end
