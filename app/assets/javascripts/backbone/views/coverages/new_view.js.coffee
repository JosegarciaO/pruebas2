CertOrbe.Views.Coverages ||= {}

class CertOrbe.Views.Coverages.NewView extends CertOrbe.Views.Coverages.FormView
  template: (data) -> $("#backboneTemplatesCoveragesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_coverage": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
