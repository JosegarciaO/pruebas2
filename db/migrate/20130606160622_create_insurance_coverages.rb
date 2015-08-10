class CreateInsuranceCoverages < ActiveRecord::Migration
  def up
    create_table :insurance_coverages do |t|
      t.references :insurance
      t.references :coverage
      t.decimal :deductible_min, :precision => 4, :scale => 2

      t.timestamps
    end
    add_index :insurance_coverages, :insurance_id, :name => 'fk_insurance_insurance_coverage'
    add_index :insurance_coverages, :coverage_id, :name => 'fk_coverage_insurance_coverage'
  end

  def down
    drop_table :insurance_coverages
  end
end
