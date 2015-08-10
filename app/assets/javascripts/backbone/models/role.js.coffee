class CertOrbe.Models.Role extends CertOrbe.Models.BaseModel
  paramRoot: 'role'
  urlRoot: 'roles'

  defaults:
    name: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  @paramRoot : 'role'
  @urlRoot   : 'roles'

class CertOrbe.Collections.RolesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Role
  url   : '/roles'
