class CertOrbe.Models.PossessionDescription extends CertOrbe.Models.BaseModel
  paramRoot: 'possession_description'
  urlRoot: 'possession_descriptions'

  defaults:
    name: null
    possession: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'possession_description'
  @urlRoot   : 'possession_descriptions'

class CertOrbe.Collections.PossessionDescriptionsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.PossessionDescription
  url   : '/possession_descriptions'
