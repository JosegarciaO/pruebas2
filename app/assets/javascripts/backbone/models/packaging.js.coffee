class CertOrbe.Models.Packaging extends CertOrbe.Models.BaseModel
  paramRoot: 'packaging'
  urlRoot: 'packagings'

  defaults:
    name: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'packaging'
  @urlRoot   : 'packagings'

class CertOrbe.Collections.PackagingsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Packaging
  url   : '/packagings'
