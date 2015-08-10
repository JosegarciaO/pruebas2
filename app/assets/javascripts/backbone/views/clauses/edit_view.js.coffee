CertOrbe.Views.Clauses ||= {}

class CertOrbe.Views.Clauses.EditView extends CertOrbe.Views.Clauses.FormView
  template: (data) -> $("#backboneTemplatesClausesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_clause" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_clause").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
