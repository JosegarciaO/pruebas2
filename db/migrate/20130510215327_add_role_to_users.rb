class AddRoleToUsers < ActiveRecord::Migration
	def up
		add_column :users, :role_id, :integer, references: :role
	end

	def down
		remove_column :users, :role_id
	end
end
