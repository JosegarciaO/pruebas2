class CertOrbe.Models.Insurance extends CertOrbe.Models.BaseModel
  paramRoot: 'insurance'
  urlRoot: 'insurances'

  defaults:
    name: null
    tin: null
    street: null
    area: null
    city_id: null
    state_id: null
    zip_code: null
    expedition_fee_mx: null
    expedition_fee_us: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  hasMany:
    annexes:
      collection:  "AnnexesCollection"
      isNested:  true
    insurance_possessions:
      collection:  "InsurancePossessionsCollection"
      isNested:  true
    insurance_coverages:
      collection:  "InsuranceCoveragesCollection"
      isNested:  true

  @paramRoot : 'insurance'
  @urlRoot   : 'insurances'

class CertOrbe.Collections.InsurancesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Insurance
  url   : '/insurances'
