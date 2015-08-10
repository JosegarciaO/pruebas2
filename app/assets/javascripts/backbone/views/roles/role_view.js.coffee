CertOrbe.Views.Roles ||= {}

class CertOrbe.Views.Roles.RoleView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesRolesRole").tmpl(data)

  tagName: "tr"

  events:
    _.extend( _.clone(@__super__.events),
     {}
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this
