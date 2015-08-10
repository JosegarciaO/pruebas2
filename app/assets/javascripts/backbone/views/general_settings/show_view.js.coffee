CertOrbe.Views.GeneralSettings ||= {}

class CertOrbe.Views.GeneralSettings.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesGeneralSettingsShow").tmpl(data)

  events:
    _.extend( _.clone(@__super__.events),
      {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this

  destroy: (e) ->
    super(e, success: () -> window.location.hash = "")

  remove: ->
    super()
