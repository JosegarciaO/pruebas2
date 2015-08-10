class AddClausesTransportations < ActiveRecord::Migration
  def self.up
    create_table :clauses_transportations, :id => false do |t|
      t.references :clause, :transportation
    end

    add_index :clauses_transportations, [:clause_id, :transportation_id]
  end

  def self.down
    drop_table :clauses_transportations
  end
end
