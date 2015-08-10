CertOrbe.Views.Cities ||= {}

class CertOrbe.Views.Cities.EditView extends CertOrbe.Views.Cities.FormView
  template: (data) -> $("#backboneTemplatesCitiesEdit").tmpl(data)

  initialize: ->
    @model.bind("error", @renderErrors)
    @model.prepareToEdit()

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_city" : "update"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_city").backboneLink(@model)
    return this

  remove: ->
    @model.unbind("error", @renderErrors)
    super()

  fillSelects: ->
    @fillOneSelect("#country_id", "#city_state_id", "countries/@/states")

  fillOneSelect: (parent, child, url) ->
    $(child).html('')
    select = $(parent)
    url    = url.replace("@",select.val())

    @fill_select({
      url:  url
      target: child
      select: select
      model: @model
    },false)
