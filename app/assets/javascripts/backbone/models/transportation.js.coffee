class CertOrbe.Models.Transportation extends CertOrbe.Models.BaseModel
  paramRoot: 'transportation'
  urlRoot: 'transportations'

  defaults:
    name: null
    clause_ids: []

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'transportation'
  @urlRoot   : 'transportations'

  # has_many : 'clauses'

class CertOrbe.Collections.TransportationsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Transportation
  url   : '/transportations'
