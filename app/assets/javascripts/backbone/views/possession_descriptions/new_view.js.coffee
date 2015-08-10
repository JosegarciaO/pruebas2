CertOrbe.Views.PossessionDescriptions ||= {}

class CertOrbe.Views.PossessionDescriptions.NewView extends CertOrbe.Views.PossessionDescriptions.FormView
  template: (data) -> $("#backboneTemplatesPossessionDescriptionsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_possession_description": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_possession_description").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
