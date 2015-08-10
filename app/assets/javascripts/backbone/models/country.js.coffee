class CertOrbe.Models.Country extends CertOrbe.Models.BaseModel
  paramRoot: 'country'
  urlRoot: 'countries'

  defaults:
    name: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'country'
  @urlRoot   : 'countries'

class CertOrbe.Collections.CountriesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Country
  url   : '/countries'
