CertOrbe.Views.PossessionDescriptions ||= {}

class CertOrbe.Views.PossessionDescriptions.PossessionDescriptionView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPossessionDescriptionsPossessionDescription").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
