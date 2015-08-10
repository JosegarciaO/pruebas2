class CertOrbe.Models.InsurancePossession extends CertOrbe.Models.BaseModel
  paramRoot: 'insurance_possession'
  urlRoot: 'insurance_possessions'

  defaults:
    insurance_id: null
    possession_id: null
    has_max_amount: null
    max_amount: 0

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  belongsTo:
    insurance:
      model: "Insurance"

  @paramRoot : 'insurance_possession'
  @urlRoot   : 'insurance_possessions'

class CertOrbe.Collections.InsurancePossessionsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.InsurancePossession
  url   : '/insurance_possessions'
