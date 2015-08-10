module ApiV1::GeneralSetting
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :iva
      t.add :base_fee_min
      t.add :packaging_default
      t.add :exchange_usd
      t.add :medidas_seguridad_default
      t.add :deducible_default
      t.add :certificate_consecutive
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
