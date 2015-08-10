CertOrbe.Views.Policies ||= {}

class CertOrbe.Views.Policies.NewView extends CertOrbe.Views.Policies.FormView
  template: (data) -> $("#backboneTemplatesPoliciesNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_policy": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_policy").backboneLink(@model)
    @$(".calendario").datepicker()
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
