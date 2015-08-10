CertOrbe.Views.Packagings ||= {}

class CertOrbe.Views.Packagings.NewView extends CertOrbe.Views.Packagings.FormView
  template: (data) -> $("#backboneTemplatesPackagingsNew").tmpl(data)

  initialize: (options) ->
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_packaging": "save"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_packaging").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()
