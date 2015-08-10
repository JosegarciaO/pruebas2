module ApiV1::CertificateRequest
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :num_constancia  # folio unico de la constancia/certificado
      t.add :nombre
      t.add :direccion
      t.add :city_id
      t.add lambda { |c| c.city.state_id }, :as => :state_id
      t.add lambda { |c| c.city.state.country_id }, :as => :country_id
      t.add :cp
      t.add :rfc
      t.add :fecha_salida
      t.add :fecha_llegada
      t.add :importe
      t.add :base_fee
      t.add :expedition_fee
      t.add :iva
      t.add :iva_amount
      t.add :total_prime
      t.add :moneda
      t.add lambda { |c| ListasGenerales::getNombreMoneda(c.moneda) }, :as => :moneda_name
      t.add :beneficiario
      t.add :deducibles
      t.add :medida_seguridad
      t.add :possession_id
      t.add :codigo_seguridad
      t.add lambda { |c| c.esCodSeguridadCorrecto? }, :as => :codigo_correcto
      t.add :status
      t.add lambda { |c| ListasGenerales::getNombreStatus(c.status) }, :as => :status_name
      t.add :cancelado
      t.add :user_id
      t.add :policy_id
      t.add lambda { |c| c.policy ? c.policy.insurance.name : nil }, :as => :insurance_name
      t.add :use_beneficiario
      t.add :city_from_id
      t.add lambda { |c| c.city_from.state_id }, :as => :state_from_id
      t.add lambda { |c| c.city_from.state.country_id }, :as => :country_from_id
      t.add :city_to_id
      t.add lambda { |c| c.city_to.state_id }, :as => :state_to_id
      t.add lambda { |c| c.city_to.state.country_id }, :as => :country_to_id
      t.add :possession_description
      t.add :packaging
      t.add :same_city
      t.add :num_invoice
      t.add :emission_date
      t.add :transport_ground
      t.add :transport_air
      t.add :transport_maritime
      t.add :transport_rail
      t.add :transport_package
      t.add :transportation_ids
      t.add :get_transportation_text, :as => :medio_transporte_name
    end

    api_accessible :list, :extend => :base do |t|
      t.add :city
      t.add :city_from
      t.add :city_to
      t.add :policy
      t.add :possession
      t.add :certificate_request_coverages
      t.add :certificate_request_clauses
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
