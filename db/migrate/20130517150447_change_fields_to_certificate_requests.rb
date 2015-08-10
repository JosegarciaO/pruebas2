class ChangeFieldsToCertificateRequests < ActiveRecord::Migration
  def up
  	remove_column :certificate_requests, :bienes
  	remove_column :certificate_requests, :descripcion
  	remove_column :certificate_requests, :embalaje

  	add_column :certificate_requests, :possession_id, :integer, references: :possessions
  	add_column :certificate_requests, :possession_description_id, :integer, references: :possession_descriptions
  	add_column :certificate_requests, :packaging_id, :integer, references: :packagings

  	add_index :certificate_requests, :possession_id, :name => "fk_possession"
  	add_index :certificate_requests, :possession_description_id, :name => "fk_possession_description"
  	add_index :certificate_requests, :packaging_id, :name => "fk_packaging"
  end

  def down
  	add_column :certificate_requests, :bienes, :string
  	add_column :certificate_requests, :descripcion, :string
  	add_column :certificate_requests, :embalaje, :string

  	remove_index :certificate_requests, :name => "fk_possession"
	remove_index :certificate_requests, :name => "fk_possession_description"
	remove_index :certificate_requests, :name => "fk_packaging"

  	remove_column :certificate_requests, :possession_id
	remove_column :certificate_requests, :possession_description_id
	remove_column :certificate_requests, :packaging_id
  end
end
