class RemoveFieldsPolicyRightsToInsurances < ActiveRecord::Migration
  def up
  	remove_column :insurances, :policy_right_mx
  	remove_column :insurances, :policy_right_us
  end

  def down
	add_column :insurances, :policy_right_mx, :decimal, :precision => 8, :scale => 2, :default => 0
	add_column :insurances, :policy_right_us, :decimal, :precision => 8, :scale => 2, :default => 0
  end
end
