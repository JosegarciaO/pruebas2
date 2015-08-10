CertOrbe.Views.InsurancePossessions ||= {}

class CertOrbe.Views.InsurancePossessions.NewView extends CertOrbe.Views.InsurancePossessions.FormView
  template: (data) -> $("#backboneTemplatesInsurancePossessionsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_insurance_possession": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_insurance_possession").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
