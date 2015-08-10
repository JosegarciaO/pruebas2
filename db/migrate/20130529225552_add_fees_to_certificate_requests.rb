class AddFeesToCertificateRequests < ActiveRecord::Migration
  def up
  	add_column :certificate_requests, :base_fee, :decimal, :precision => 4, :scale => 2, :default => 0
  	add_column :certificate_requests, :expedition_fee, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :certificate_requests, :policy_right, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :certificate_requests, :iva, :decimal, :precision => 4, :scale => 2, :default => 0
    add_column :certificate_requests, :iva_amount, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :certificate_requests, :total_prime, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def down
  	remove_column :certificate_requests, :base_fee
  	remove_column :certificate_requests, :expedition_fee
  	remove_column :certificate_requests, :policy_right
  	remove_column :certificate_requests, :iva
    remove_column :certificate_requests, :iva_amount
  	remove_column :certificate_requests, :total_prime
  end
end
