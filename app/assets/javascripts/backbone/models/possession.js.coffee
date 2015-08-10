class CertOrbe.Models.Possession extends CertOrbe.Models.BaseModel
  paramRoot: 'possession'
  urlRoot: 'possessions'

  defaults:
    name: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'possession'
  @urlRoot   : 'possessions'

class CertOrbe.Collections.PossessionsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Possession
  url   : '/possessions'
