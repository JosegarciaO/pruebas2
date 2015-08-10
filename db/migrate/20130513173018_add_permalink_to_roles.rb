class AddPermalinkToRoles < ActiveRecord::Migration
  def up
  	add_column :roles, :permalink, :string
  end

  def down
  	remove_column :roles, :permalink
  end
end
