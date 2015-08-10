class AddFieldsActivoToPossessionsAndCoverages < ActiveRecord::Migration
  def up
  	add_column :possessions, :active, :boolean, :default => 1
  	add_column :coverages, :active, :boolean, :default => 1
  end

  def down
  	remove_column :possessions, :active
  	remove_column :coverages, :active
  end
end
