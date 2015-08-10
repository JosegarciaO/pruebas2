module ApiV1::Policy
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :folio
      t.add :moneda
      t.add lambda { |r| ListasGenerales::getNombreMoneda(r.moneda) }, :as => :moneda_name
      t.add :insurance_id
      t.add :date_start
      t.add :date_end
      t.add lambda { |r| r.esActiva? }, :as => :activa
    end

    api_accessible :list, :extend => :base do |t|
      t.add :insurance, :template => :base
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
