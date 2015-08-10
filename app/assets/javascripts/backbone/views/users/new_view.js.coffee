CertOrbe.Views.Users ||= {}

class CertOrbe.Views.Users.NewView extends CertOrbe.Views.Users.FormView
  template: (data) -> $("#backboneTemplatesUsersNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_user": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_user").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
