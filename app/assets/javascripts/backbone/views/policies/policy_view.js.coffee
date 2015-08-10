CertOrbe.Views.Policies ||= {}

class CertOrbe.Views.Policies.PolicyView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPoliciesPolicy").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
