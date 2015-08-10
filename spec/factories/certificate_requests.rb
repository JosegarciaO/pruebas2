# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :certificate_request do
    nombre "LUIS LOMELI"
    direccion "AV. DE LA PRADERA #18503 FRACC: PRADERA DORADA"
    cp "82146"
    rfc "LOMA8009152L8"
    fecha_salida Date.current()
    fecha_llegada Date.current() + 1
    moneda "MX"
    importe 120000.00
    # base_fee 0.12  # el minimo en general_settings es 0.12
    # expedition_fee 100
    use_beneficiario 1
    beneficiario "MISMO"
    deducibles "20% S.V.T.E. para toda y cada pérdida ocasionada por el riesgo de Robo y/o Asalto."
    # medida_seguridad "Para el transporte terrestre el asegurado garantiza el uso de caminos de cuota cuando estén disponibles."
    possession_description "Descripcion de los bienes"
    packaging "Descripcion del embalaje"
    num_invoice "A-12345"
    transport_ground true
    transport_air false
    transport_maritime false
    transport_rail false
    transport_package false

    factory :cualsi_request do
        after(:build) do |req|
            FactoryGirl.create(:general_setting)

            req.city = FactoryGirl.create(:city_guadalajara)
            req.city_from = FactoryGirl.create(:city_miami)
            req.city_to   = FactoryGirl.create(:city_toronto)
            req.possession = FactoryGirl.create(:possession_metales)
            # req.policy = FactoryGirl.create(:policy_chartis)
            # req.certificate_request_coverages << FactoryGirl.create(:cert_req_robo_total, certificate_request_id: req.id)
        end
    end

  end
end
