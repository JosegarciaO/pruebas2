class CreateInsurancePossessions < ActiveRecord::Migration
  def up
    create_table :insurance_possessions do |t|
      t.references :insurance
      t.references :possession
      t.boolean :has_max_amount, :default => 0
      t.decimal :max_amount, :precision => 12, :scale => 2

      t.timestamps
    end
    add_index :insurance_possessions, :insurance_id, :name => 'fk_insurance_insurance_possession'
    add_index :insurance_possessions, :possession_id, :name => 'fk_possession_insurance_possession'
  end

  def down
    drop_table :insurance_possessions
  end
end
