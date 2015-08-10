class CertOrbe.Routers.UsersRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @users = new CertOrbe.Collections.UsersCollection()
    @users.reset options.users

  routes:
    "/new"      : "newUser"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newUser: ->
    @newUserView = new CertOrbe.Views.Users.NewView(collection: @users)
    $("#users").html(@newUserView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Users.IndexView(users: @users)
    $("#users").html(@indexView.render().el)

  show: (id) ->
    user = @users.get(id)

    if user?
      user.setAllValues()

      @showView = new CertOrbe.Views.Users.ShowView(model: user)
      $("#users").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    user = @users.get(id)

    if user?
      user.setAllValues()

      @editView = new CertOrbe.Views.Users.EditView(model: user)
      $("#users").html(@editView.render().el)
    else @resourceNotFound()
