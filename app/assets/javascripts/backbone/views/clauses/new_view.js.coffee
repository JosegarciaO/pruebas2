CertOrbe.Views.Clauses ||= {}

class CertOrbe.Views.Clauses.NewView extends CertOrbe.Views.Clauses.FormView
  template: (data) -> $("#backboneTemplatesClausesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_clause": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_clause").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
