class ChangeFieldsToInsurances < ActiveRecord::Migration
	def up
		remove_column :insurances, :deductible_min
		add_column :insurances, :max_amount, :decimal, :precision => 12, :scale => 2, :default => 0

		# -- Asigna $4'000,000 a todas las aseguradoras existentes
		Insurance.update_all ["max_amount = ?", 4000000]
	end

	def down
		add_column :insurances, :deductible_min, :decimal, :precision => 4, :scale => 2, :default => 0
		remove_column :insurances, :max_amount
	end
end
