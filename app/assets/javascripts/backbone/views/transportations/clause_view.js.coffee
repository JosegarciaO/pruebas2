CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.ClauseView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesTransportationsClause").tmpl(data)

  tagName: 'li'

  events:
    _.extend( _.clone(@__super__.events),
      "change .chk_clause" : "changeClause"
    )

  initialize: (options) ->
    @transportation = options.transportation
    @model.set({checked: jQuery.inArray(@model.id, @transportation.get('clause_ids')) >= 0 ? "true" : "false" })

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this

  changeClause: (e) ->
    checked = e.currentTarget.checked

    if (checked)
      @transportation.get('clause_ids').push(@model.id)
    else
      index = jQuery.inArray(@model.id, @transportation.get('clause_ids'));
      if (index >= 0)
        @transportation.get('clause_ids').splice(index, 1);