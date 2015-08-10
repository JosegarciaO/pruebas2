CertOrbe.Views.Possessions ||= {}

class CertOrbe.Views.Possessions.NewView extends CertOrbe.Views.Possessions.FormView
  template: (data) -> $("#backboneTemplatesPossessionsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_possession": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_possession").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
