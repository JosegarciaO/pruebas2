class AddFeesToInsurances < ActiveRecord::Migration
  def up
  	add_column :insurances, :expedition_fee_mx, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :insurances, :expedition_fee_us, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :insurances, :policy_right_mx, :decimal, :precision => 8, :scale => 2, :default => 0
  	add_column :insurances, :policy_right_us, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def down
  	remove_column :insurances, :expedition_fee_mx
  	remove_column :insurances, :expedition_fee_us
  	remove_column :insurances, :policy_right_mx
  	remove_column :insurances, :policy_right_us
  end
end
