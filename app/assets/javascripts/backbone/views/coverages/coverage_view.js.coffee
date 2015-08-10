CertOrbe.Views.Coverages ||= {}

class CertOrbe.Views.Coverages.CoverageView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCoveragesCoverage").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
