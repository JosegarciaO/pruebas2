CertOrbe.Views.Packagings ||= {}

class CertOrbe.Views.Packagings.EditView extends CertOrbe.Views.Packagings.FormView
  template: (data) -> $("#backboneTemplatesPackagingsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_packaging" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_packaging").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
