class ChangeFieldsToPolicies < ActiveRecord::Migration
  def up
  	add_column :policies, :date_start, :date
  	add_column :policies, :date_end, :date

  	change_column :policies, :folio, :string, :limit => 50
  	change_column :policies, :moneda, :string, :limit => 1
  	change_column :policies, :activa, :boolean, :default => false
  end

  def down
  	remove_column :policies, :date_start
  	remove_column :policies, :date_end

  	change_column :policies, :folio, :string
  	change_column :policies, :moneda, :string
  	change_column :policies, :activa, :boolean
  end
end
