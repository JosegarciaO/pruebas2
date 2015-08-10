CertOrbe.Views.Possessions ||= {}

class CertOrbe.Views.Possessions.PossessionView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPossessionsPossession").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
