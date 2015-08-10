class CreateAnnexes < ActiveRecord::Migration
  def change
    create_table :annexes do |t|
      t.integer :insurance_id

      t.timestamps
    end
    add_attachment :annexes, :image
  end
end
