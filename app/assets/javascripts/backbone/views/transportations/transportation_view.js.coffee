CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.TransportationView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesTransportationsTransportation").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
