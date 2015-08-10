CertOrbe.Views.GeneralSettings ||= {}

class CertOrbe.Views.GeneralSettings.EditView extends CertOrbe.Views.GeneralSettings.FormView
  template: (data) -> $("#backboneTemplatesGeneralSettingsEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_general_setting" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_general_setting").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
