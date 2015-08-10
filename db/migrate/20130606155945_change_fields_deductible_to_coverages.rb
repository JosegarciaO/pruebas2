class ChangeFieldsDeductibleToCoverages < ActiveRecord::Migration
	def up
		remove_column :coverages, :deductible_editable
	end

	def down
		add_column :coverages, :deductible_editable, :boolean, :default => false
	end
end
