class RemoveActivaFromPolicies < ActiveRecord::Migration
  def up
  	remove_column :policies, :activa
  end

  def down
  	add_column :policies, :activa, :boolean, :default => false
  end
end
