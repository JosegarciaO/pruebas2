class CertOrbe.Models.User extends CertOrbe.Models.BaseModel
  paramRoot: 'user'
  urlRoot: 'users'

  defaults:
    email: null
    password: null
    password_confirmation: null
    role_id: null
    # name: null

  validate: (attrs) ->
    return @validates(attrs, {
      email:
        presence: true
        email: true

      password:
        presence:
          on: "create"

      password_confirmation:
        presence:
          on: "create"
        equalTo: "password"

      role_id:
        presence: true
    })

  belongsTo:
    role:
      model: "Role"


  @paramRoot : 'user'
  @urlRoot   : 'users'

class CertOrbe.Collections.UsersCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.User
  url   : '/users'
