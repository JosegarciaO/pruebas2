class CertOrbe.Models.City extends CertOrbe.Models.BaseModel
  paramRoot: 'city'
  urlRoot: 'cities'

  defaults:
    name: null
    state_id: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  removeWhenSaving: ['country_id']

  belongsTo:
    state:
      model: "State"

  @paramRoot : 'city'
  @urlRoot   : 'cities'

class CertOrbe.Collections.CitiesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.City
  url   : '/cities'
