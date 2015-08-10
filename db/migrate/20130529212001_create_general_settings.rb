class CreateGeneralSettings < ActiveRecord::Migration
  def up
    create_table :general_settings do |t|
      t.decimal :iva, :precision => 4, :scale => 2
      t.decimal :base_fee_min, :precision => 4, :scale => 2

      t.timestamps
    end
  end

  def down
  	drop_table :general_settings
  end
end
