CertOrbe.Views.Users ||= {}

class CertOrbe.Views.Users.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesUsersIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.users.bind('reset', @addAll)

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  addAll: () ->
    @$("#users_table tbody").empty()
    @renderPagination(@options.users)
    @options.users.each(@addOne)

  addOne: (user) ->
    view = new CertOrbe.Views.Users.UserView({model : user})
    @$("#users_table tbody").append(view.render().el)

  render: ->
    template = @template(users: @options.users.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.users.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.users)
