class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :folio
      t.string :moneda
      t.boolean :activa
      t.references :insurance

      t.timestamps
    end
    add_index :policies, :insurance_id
  end
end
