class AddDeductibleFieldsToCoverages < ActiveRecord::Migration
	def up
		add_column :coverages, :deductible_min, :decimal, :precision => 4, :scale => 2, :default => 0
		add_column :coverages, :deductible_editable, :boolean, :default => false
	end

	def down
		remove_column :coverages, :deductible_min
		remove_column :coverages, :deductible_editable
	end
end
