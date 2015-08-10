class AddFieldsAmountToPossessions < ActiveRecord::Migration
	def up
		add_column :possessions, :has_max_amount, :boolean, :default => 0
		add_column :possessions, :max_amount, :decimal, :precision => 12, :scale => 2, :default => 0

		if rec = Possession.find_by_name("azucar")
			rec.has_max_amount = true
			rec.max_amount = 4000000
			rec.save
		end
	end

	def down
		remove_column :possessions, :has_max_amount
		remove_column :possessions, :max_amount
	end
end
