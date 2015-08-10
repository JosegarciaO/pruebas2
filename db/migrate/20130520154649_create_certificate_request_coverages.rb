class CreateCertificateRequestCoverages < ActiveRecord::Migration
  def change
    create_table :certificate_request_coverages do |t|
      t.references :certificate_request
      t.references :coverage

      t.timestamps
    end
    add_index :certificate_request_coverages, :certificate_request_id
    add_index :certificate_request_coverages, :coverage_id
  end
end
