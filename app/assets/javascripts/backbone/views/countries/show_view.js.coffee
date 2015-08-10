CertOrbe.Views.Countries ||= {}

class CertOrbe.Views.Countries.ShowView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCountriesShow").tmpl(data)

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
