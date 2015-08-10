class AddCountryIdToStates < ActiveRecord::Migration
	def up
		add_column :states, :country_id, :integer, references: :country
	end

	def down
		remove_column :states, :country_id
	end
end