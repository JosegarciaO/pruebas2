class ChangeTransportationToCertificateRequests < ActiveRecord::Migration
	def up
		add_column :certificate_requests, :transport_ground,   :boolean, :default => false
		add_column :certificate_requests, :transport_air,      :boolean, :default => false
		add_column :certificate_requests, :transport_maritime, :boolean, :default => false
		add_column :certificate_requests, :transport_rail,     :boolean, :default => false
		add_column :certificate_requests, :transport_package,  :boolean, :default => false

		CertificateRequest.all.each do |rec|
			case rec.medio_transporte
			when 'T'
				rec.transport_ground = 1
			when 'A'
				rec.transport_air = 1
			when 'M'
				rec.transport_maritime = 1
			when 'F'
				rec.transport_rail = 1
			when 'P'
				rec.transport_package = 1
			else
				rec.transport_ground = 1
			end
			rec.save
		end

		remove_column :certificate_requests, :medio_transporte
	end

	def down
		remove_column :certificate_requests, :transport_ground
		remove_column :certificate_requests, :transport_air
		remove_column :certificate_requests, :transport_maritime
		remove_column :certificate_requests, :transport_rail
		remove_column :certificate_requests, :transport_package

		add_column :certificate_requests, :medio_transporte, :string, :limit => 1
	end
end
