class CertOrbe.Models.Clause extends CertOrbe.Models.BaseModel
  paramRoot: 'clause'
  urlRoot: 'clauses'

  defaults:
    name: null
    isfixed: null
    active: null
    transportationFixed: null

  removeWhenSaving: ['transportationFixed']

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'clause'
  @urlRoot   : 'clauses'

class CertOrbe.Collections.ClausesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Clause
  url   : '/clauses'
