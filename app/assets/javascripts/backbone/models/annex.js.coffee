class CertOrbe.Models.Annex extends CertOrbe.Models.BaseModel
  paramRoot: 'annex'
  urlRoot: 'annexes'

  defaults:
    image: null
    insurance_id: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  belongsTo:
    insurance:
      model: "Insurance"

  @paramRoot : 'annex'
  @urlRoot   : 'annexes'

class CertOrbe.Collections.AnnexesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Annex
  url   : '/annexes'