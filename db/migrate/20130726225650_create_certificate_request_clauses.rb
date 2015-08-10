class CreateCertificateRequestClauses < ActiveRecord::Migration
  def change
    create_table :certificate_request_clauses do |t|
      t.references :certificate_request
      t.references :clause
      t.boolean :is_included

      t.timestamps
    end
    add_index :certificate_request_clauses, :certificate_request_id
    add_index :certificate_request_clauses, :clause_id
  end
end
