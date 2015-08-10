CertOrbe.Views.Roles ||= {}

class CertOrbe.Views.Roles.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesRolesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.roles.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_roles" : "refreshRoles"

  refreshRoles: (e) ->
    e.preventDefault()
    @options.roles.fetch()

  addAll: () ->
    @$("#roles_table tbody").empty()
    @renderPagination(@options.roles)
    @options.roles.each(@addOne)

  addOne: (role) ->
    view = new CertOrbe.Views.Roles.RoleView({model : role})
    @$("#roles_table tbody").append(view.render().el)

  render: ->
    template = @template(roles: @options.roles.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.roles.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.roles)
