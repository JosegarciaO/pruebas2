class ChangeTotalesToCertificateRequests < ActiveRecord::Migration
	def up
		change_column :certificate_requests, :importe, :decimal, :precision => 12, :scale => 2, :default => 0
		change_column :certificate_requests, :total_prime, :decimal, :precision => 12, :scale => 2, :default => 0
	end

	def down
		change_column :certificate_requests, :importe, :decimal, :precision => 9, :scale => 2, :default => 0
		change_column :certificate_requests, :total_prime, :decimal, :precision => 8, :scale => 2, :default => 0
	end
end
