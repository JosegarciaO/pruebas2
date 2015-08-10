class AddExchangeUsdToGeneralSettings < ActiveRecord::Migration
	def up
		add_column :general_settings, :exchange_usd, :decimal, :precision => 8, :scale => 2, :default => 0
	end

	def down
		remove_column :general_settings, :exchange_usd
	end
end
