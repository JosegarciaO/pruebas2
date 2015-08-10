class CreateClauses < ActiveRecord::Migration
  def change
    create_table :clauses do |t|
      t.string :name
      t.boolean :isfixed, :default => 0
      t.boolean :active, :default => 1

      t.timestamps
    end
  end
end
