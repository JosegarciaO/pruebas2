class AddDeductibleToCertificateRequestCoverages < ActiveRecord::Migration
  def up
  	add_column :certificate_request_coverages, :deductible, :decimal, :precision => 4, :scale => 2, :default => 0
  end

  def down
  	remove_column :certificate_request_coverages, :deductible
  end
end
