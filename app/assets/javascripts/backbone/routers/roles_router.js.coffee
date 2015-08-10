class CertOrbe.Routers.RolesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @roles = new CertOrbe.Collections.RolesCollection()
    @roles.reset options.roles

  routes:
    "/new"      : "newRole"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newRole: ->
    @newRoleView = new CertOrbe.Views.Roles.NewView(collection: @roles)
    $("#roles").html(@newRoleView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Roles.IndexView(roles: @roles)
    $("#roles").html(@indexView.render().el)

  show: (id) ->
    role = @roles.get(id)

    if role?
      role.setAllValues()

      @showView = new CertOrbe.Views.Roles.ShowView(model: role)
      $("#roles").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    role = @roles.get(id)

    if role?
      role.setAllValues()

      @editView = new CertOrbe.Views.Roles.EditView(model: role)
      $("#roles").html(@editView.render().el)
    else @resourceNotFound()
