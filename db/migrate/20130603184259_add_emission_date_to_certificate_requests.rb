class AddEmissionDateToCertificateRequests < ActiveRecord::Migration
  def up
  	add_column :certificate_requests, :emission_date, :date
  	add_index :certificate_requests, :emission_date, :name => "ak_fecha_emision"
  end

  def down
  	remove_column :certificate_requests, :emission_date
  end
end
