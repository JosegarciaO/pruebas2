class ChangeFieldsToCertificateRequests2 < ActiveRecord::Migration
  def up
  	remove_column :certificate_requests, :ciudad_desde
  	remove_column :certificate_requests, :ciudad_hasta
  	remove_column :certificate_requests, :num_conocimiento
  	remove_column :certificate_requests, :folio
  	remove_column :certificate_requests, :embarque
  	remove_column :certificate_requests, :possession_description_id
  	remove_column :certificate_requests, :packaging_id

  	drop_table :possession_descriptions
  	drop_table :packagings

  	add_column :certificate_requests, :use_beneficiario, :boolean, :default => false
  	add_column :certificate_requests, :city_from_id, :integer, references: :cities
  	add_column :certificate_requests, :city_to_id,   :integer, references: :cities
  	add_column :certificate_requests, :possession_description, :string
  	add_column :certificate_requests, :packaging, :string
  	add_column :certificate_requests, :same_city, :boolean, :default => false
  	add_column :certificate_requests, :num_invoice, :string, :limit => 50

    add_index :certificate_requests, :city_from_id, :name => 'fk_city_from'
    add_index :certificate_requests, :city_to_id, :name => 'fk_city_to'

  	change_column :certificate_requests, :cp, :string, :limit => 10
  	change_column :certificate_requests, :rfc, :string, :limit => 15
  	change_column :certificate_requests, :medio_transporte, :string, :limit => 1
  	change_column :certificate_requests, :moneda, :string, :limit => 1

  end

  def down
  	add_column :certificate_requests, :ciudad_desde, :integer, :default => 0
  	add_column :certificate_requests, :ciudad_hasta, :integer, :default => 0
  	add_column :certificate_requests, :num_conocimiento, :string
  	add_column :certificate_requests, :folio, :string
  	add_column :certificate_requests, :embarque, :string
  	add_column :certificate_requests, :possession_description_id, :integer, references: :possession_descriptions
  	add_column :certificate_requests, :packaging_id, :integer, references: :packagings

  	create_table :possession_descriptions do |t|
      t.string :name
      t.references :possession
      t.timestamps
    end
    add_index :possession_descriptions, :possession_id, :name => "fk_possession_id"

    create_table :packagings do |t|
      t.string :name
      t.timestamps
    end

  	add_index :certificate_requests, :possession_description_id, :name => "fk_possession_description"
  	add_index :certificate_requests, :packaging_id, :name => "fk_packaging"

  	remove_column :certificate_requests, :use_beneficiario
  	remove_column :certificate_requests, :city_from
  	remove_column :certificate_requests, :city_to
  	remove_column :certificate_requests, :possession_description
  	remove_column :certificate_requests, :packaging
  	remove_column :certificate_requests, :same_city
  	remove_column :certificate_requests, :num_invoice

  	change_column :certificate_requests, :cp, :string
  	change_column :certificate_requests, :rfc, :string
  	change_column :certificate_requests, :medio_transporte, :string
  	change_column :certificate_requests, :moneda, :string

  end
end
