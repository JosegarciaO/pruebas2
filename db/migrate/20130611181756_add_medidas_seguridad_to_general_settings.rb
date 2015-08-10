class AddMedidasSeguridadToGeneralSettings < ActiveRecord::Migration
	def up
		add_column :general_settings, :medidas_seguridad_default, :text
	end

	def down
		remove_column :general_settings, :medidas_seguridad_default
	end
end
