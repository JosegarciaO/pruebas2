CertOrbe.Views.InsuranceCoverages ||= {}

class CertOrbe.Views.InsuranceCoverages.NewView extends CertOrbe.Views.InsuranceCoverages.FormView
  template: (data) -> $("#backboneTemplatesInsuranceCoveragesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_insurance_coverage": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_insurance_coverage").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
