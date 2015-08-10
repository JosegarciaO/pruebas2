class AddIncluirToCertificateRequestCoverages < ActiveRecord::Migration
  def up
  	add_column :certificate_request_coverages, :incluir, :boolean, :default => 0
  end

  def down
  	remove_column :certificate_request_coverages, :incluir
  end
end
