CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesTransportationsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.transportations.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_transportations" : "refreshTransportations"

  refreshTransportations: (e) ->
    e.preventDefault()
    @options.transportations.fetch()

  addAll: () ->
    @$("#transportations_table tbody").empty()
    @renderPagination(@options.transportations)
    @options.transportations.each(@addOne)

  addOne: (transportation) ->
    view = new CertOrbe.Views.Transportations.TransportationView({model : transportation})
    @$("#transportations_table tbody").append(view.render().el)

  render: ->
    template = @template(transportations: @options.transportations.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.transportations.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.transportations)
