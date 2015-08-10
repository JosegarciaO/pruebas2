class CertOrbe.Models.State extends CertOrbe.Models.BaseModel
  paramRoot: 'state'
  urlRoot: 'states'

  defaults:
    name: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  belongsTo:
    country:
      model: "Country"

  @paramRoot : 'state'
  @urlRoot   : 'states'

class CertOrbe.Collections.StatesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.State
  url   : '/states'
