class AddDeducibleDefaultToGeneralSettings < ActiveRecord::Migration
	def up
		add_column :general_settings, :deducible_default, :text
	end

	def down
		remove_column :general_settings, :deducible_default
	end
end
