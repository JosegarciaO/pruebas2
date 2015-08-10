CertOrbe.Views.Clauses ||= {}

class CertOrbe.Views.Clauses.ClauseView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesClausesClause").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
