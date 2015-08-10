class ChangeFieldsToCertificateRequest < ActiveRecord::Migration
  def up
  	remove_column :certificate_requests, :riesgos_cubiertos
    add_column :certificate_requests, :codigo_seguridad, :string
    add_column :certificate_requests, :status, :integer, :default => 1
    add_column :certificate_requests, :cancelado, :boolean, :default => false
    add_column :certificate_requests, :user_id, :integer, references: :users
    add_column :certificate_requests, :policy_id, :integer, references: :policies
  end

  def down
  	add_column :certificate_requests, :riesgos_cubiertos, :string
    remove_column :certificate_requests, :codigo_seguridad
    remove_column :certificate_requests, :status
    remove_column :certificate_requests, :cancelado
    remove_column :certificate_requests, :user_id
    remove_column :certificate_requests, :policy_id
  end
end
