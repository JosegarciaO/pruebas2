CertOrbe.Views.Countries ||= {}

class CertOrbe.Views.Countries.EditView extends CertOrbe.Views.Countries.FormView
  template: (data) -> $("#backboneTemplatesCountriesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_country" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_country").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
