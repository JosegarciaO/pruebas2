CertOrbe.Views.Users ||= {}

class CertOrbe.Views.Users.EditView extends CertOrbe.Views.Users.FormView
  template: (data) -> $("#backboneTemplatesUsersEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_user" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_user").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
