class CertOrbe.Models.CertificateRequest extends CertOrbe.Models.BaseModel
  paramRoot: 'certificate_request'
  urlRoot: 'certificate_requests'

  defaults:
    num_constancia: null
    nombre: null
    direccion: null
    city_id: null
    cp: null
    rfc: null
    medio_transporte: null
    fecha_salida: null
    fecha_llegada: null
    importe: null
    base_fee: null
    expedition_fee: null
    iva: null
    iva_amount: null
    total_prime: null
    moneda: null
    beneficiario: null
    deducibles: null
    medida_seguridad: null
    possession_id: null
    status: null
    policy_id: null
    use_beneficiario: null
    city_from_id: null
    city_to_id: null
    possession_description: null
    packaging: null
    num_invoice: null
    cancelado: null
    transportation_ids: []

  removeWhenSaving: ['state_id','state_from_id','state_to_id','moneda_name','city','city_from','city_to',
                     'medio_transporte_name','possession','codigo_correcto','status_name',
                     'country_id','country_from_id','country_to_id','insurance_name','policy'
                    ]

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  hasMany:
    certificate_request_coverages:
      collection: "CertificateRequestCoveragesCollection"
      isNested: true
    certificate_request_clauses:
      collection: "CertificateRequestClausesCollection"
      isNested: true

  belongsTo:
    city:
      model: "City"

  @paramRoot : 'certificate_request'
  @urlRoot   : 'certificate_requests'

class CertOrbe.Collections.CertificateRequestsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.CertificateRequest
  url   : '/certificate_requests'
