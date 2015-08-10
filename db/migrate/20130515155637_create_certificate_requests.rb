class CreateCertificateRequests < ActiveRecord::Migration
  def change
    create_table :certificate_requests do |t|
      t.string :num_constancia
      t.string :nombre
      t.string :direccion
      t.references :city
      t.string :cp
      t.string :rfc
      t.string :bienes
      t.string :descripcion
      t.string :embalaje
      t.integer :ciudad_desde, :default => 0
      t.integer :ciudad_hasta, :default => 0
      t.string :medio_transporte
      t.date :fecha_salida
      t.date :fecha_llegada
      t.string :embarque
      t.string :num_conocimiento
      t.string :folio
      t.string :riesgos_cubiertos
      t.decimal :importe, :precision => 9, :scale => 2
      t.string :moneda
      t.string :beneficiario
      t.text :deducibles
      t.text :medida_seguridad

      t.timestamps
    end
    add_index :certificate_requests, :city_id, :name => "fk_ciudad"
    add_index :certificate_requests, :num_constancia, :name => "ak_num_constancia"
    add_index :certificate_requests, :nombre, :name => "ak_nombre"
    add_index :certificate_requests, :fecha_salida, :name => "ak_fecha_salida"
    add_index :certificate_requests, :fecha_llegada, :name => "ak_fecha_llegada"
  end
end
