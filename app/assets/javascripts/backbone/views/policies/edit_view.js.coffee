CertOrbe.Views.Policies ||= {}

class CertOrbe.Views.Policies.EditView extends CertOrbe.Views.Policies.FormView
  template: (data) -> $("#backboneTemplatesPoliciesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_policy" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_policy").backboneLink(@model)
    @$(".calendario").datepicker()
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
