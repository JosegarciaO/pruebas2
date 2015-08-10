class AddDetailsToInsurances < ActiveRecord::Migration
  def change
    add_column :insurances, :tin, :string
    add_column :insurances, :street, :string
    add_column :insurances, :area, :string
    add_column :insurances, :city_id, :integer
    add_column :insurances, :zip_code, :string
  end
end
