class AddCanceledAtToCertificateRequests < ActiveRecord::Migration
	def up
		add_column :certificate_requests, :canceled_at, :date
		add_index :certificate_requests, :canceled_at, :name => "ak_fecha_cancelacion"
	end

	def down
		remove_column :certificate_requests, :canceled_at
	end
end
