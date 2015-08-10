CertOrbe.Views.Packagings ||= {}

class CertOrbe.Views.Packagings.PackagingView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPackagingsPackaging").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
