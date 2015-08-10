class AddEmbalajeDefaultToGeneralSettings < ActiveRecord::Migration
  def up
  	add_column :general_settings, :packaging_default, :string
  end

  def down
  	remove_column :general_settings, :packaging_default
  end
end
