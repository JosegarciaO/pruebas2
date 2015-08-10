class AddDeductibleFieldsToInsurances < ActiveRecord::Migration
	def up
		add_column :insurances, :deductible_min, :decimal, :precision => 4, :scale => 2, :default => 0
		add_column :insurances, :deductible_text, :text
	end

	def down
		remove_column :insurances, :deductible_min
		remove_column :insurances, :deductible_text
	end
end
