class CertOrbe.Models.Policy extends CertOrbe.Models.BaseModel
  paramRoot: 'policy'
  urlRoot: 'policies'

  defaults:
    folio: null
    moneda: null
    activa: null
    date_start: null
    date_end: null
    insurance_id: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  removeWhenSaving: ['moneda_name','activa']

  belongsTo:
    insurance:
      model: "Insurance"

  @paramRoot : 'policy'
  @urlRoot   : 'policies'

class CertOrbe.Collections.PoliciesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Policy
  url   : '/policies'

  getById: (id) ->
    filtered = @.filter((policy) ->
      return policy.get("id") == id
    )

    if filtered.length > 0
      return filtered[0]
    else
      return null
