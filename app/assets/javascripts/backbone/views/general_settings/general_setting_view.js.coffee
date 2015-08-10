CertOrbe.Views.GeneralSettings ||= {}

class CertOrbe.Views.GeneralSettings.GeneralSettingView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesGeneralSettingsGeneralSetting").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
