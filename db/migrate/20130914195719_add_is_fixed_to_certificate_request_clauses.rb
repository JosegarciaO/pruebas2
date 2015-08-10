class AddIsFixedToCertificateRequestClauses < ActiveRecord::Migration
  def change
    add_column :certificate_request_clauses, :is_fixed, :boolean, :default => false
  end
end
