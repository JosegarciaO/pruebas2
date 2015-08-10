CertOrbe.Views.Users ||= {}

class CertOrbe.Views.Users.UserView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesUsersUser").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
