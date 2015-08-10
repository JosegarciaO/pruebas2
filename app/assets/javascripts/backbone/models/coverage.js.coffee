class CertOrbe.Models.Coverage extends CertOrbe.Models.BaseModel
  paramRoot: 'coverage'
  urlRoot: 'coverages'

  defaults:
    name: null
    active: null
    deductible_min: null
    deductible_editable: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'coverage'
  @urlRoot   : 'coverages'

class CertOrbe.Collections.CoveragesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Coverage
  url   : '/coverages'
