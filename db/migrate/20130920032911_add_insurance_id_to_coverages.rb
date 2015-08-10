class AddInsuranceIdToCoverages < ActiveRecord::Migration
  def change
    add_column :coverages, :insurance_id, :integer
  end
end
