class AddCertificateConsecutiveToGeneralSettings < ActiveRecord::Migration
  def up
  	add_column :general_settings, :certificate_consecutive, :integer, :default => 0
  end

  def down
  	remove_column :general_settings, :certificate_consecutive
  end
end
