CertOrbe.Views.States ||= {}

class CertOrbe.Views.States.StateView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesStatesState").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
