CertOrbe.Views.Roles ||= {}

class CertOrbe.Views.Roles.EditView extends CertOrbe.Views.Roles.FormView
  template: (data) -> $("#backboneTemplatesRolesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_role" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_role").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
