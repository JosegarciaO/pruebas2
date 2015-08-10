class ChangeFieldsToCoverages < ActiveRecord::Migration
  def up
  	change_column :coverages, :name, :text
  end

  def down
  	change_column :coverages, :name, :string
  end
end
