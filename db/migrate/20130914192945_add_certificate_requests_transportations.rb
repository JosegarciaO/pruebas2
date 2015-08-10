class AddCertificateRequestsTransportations < ActiveRecord::Migration
  def self.up
    create_table :certificate_requests_transportations, :id => false do |t|
      t.references :certificate_request, :transportation
    end

    add_index :certificate_requests_transportations, [:certificate_request_id, :transportation_id], :name => 'index_cert_request_id_transportation_id'
  end

  def self.down
    drop_table :certificate_requests_transportations
  end
end
