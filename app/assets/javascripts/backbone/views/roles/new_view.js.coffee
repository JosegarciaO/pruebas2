CertOrbe.Views.Roles ||= {}

class CertOrbe.Views.Roles.NewView extends CertOrbe.Views.Roles.FormView
  template: (data) -> $("#backboneTemplatesRolesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_role": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_role").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
