class RemovePolicyRightFromCertificateRequests < ActiveRecord::Migration
  def up
  	remove_column :certificate_requests, :policy_right
  end

  def down
  	add_column :certificate_requests, :policy_right, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
