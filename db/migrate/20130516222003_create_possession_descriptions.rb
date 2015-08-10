class CreatePossessionDescriptions < ActiveRecord::Migration
  def change
    create_table :possession_descriptions do |t|
      t.string :name
      t.references :possession

      t.timestamps
    end
    add_index :possession_descriptions, :possession_id, :name => "fk_possession_id"
  end
end
