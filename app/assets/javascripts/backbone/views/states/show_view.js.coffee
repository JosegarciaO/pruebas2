CertOrbe.Views.States ||= {}

class CertOrbe.Views.States.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesStatesShow").tmpl(data)

  events:
    _.extend( _.clone(@__super__.events),
      {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this

  destroy: (e) ->
    super(e, success: () -> window.location.hash = "")

  remove: ->
    super()
