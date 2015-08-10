class AddImagesToInsurances < ActiveRecord::Migration
  def up
	change_table :insurances do |t|
		t.has_attached_file :logo
		t.has_attached_file :firma1
		t.has_attached_file :firma2
    end
  end

  def down
  	drop_attached_file :insurances, :logo
  	drop_attached_file :insurances, :firma1
  	drop_attached_file :insurances, :firma2
  end
end
