CertOrbe.Views.GeneralSettings ||= {}

class CertOrbe.Views.GeneralSettings.NewView extends CertOrbe.Views.GeneralSettings.FormView
  template: (data) -> $("#backboneTemplatesGeneralSettingsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_general_setting": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_general_setting").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
