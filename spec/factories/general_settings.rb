# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :general_setting do
    iva 16.00
    base_fee_min 0.12
    packaging_default "Embalaje default"
    exchange_usd 13.00
    medidas_seguridad_default "Texto medidas de seguridad"
    deducible_default "Texto deducible"
  end
end
