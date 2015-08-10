CertOrbe.Views.PossessionDescriptions ||= {}

class CertOrbe.Views.PossessionDescriptions.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPossessionDescriptionsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.possessionDescriptions.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_possession_descriptions" : "refreshPossessionDescriptions"

  refreshPossessionDescriptions: (e) ->
    e.preventDefault()
    @options.possessionDescriptions.fetch()

  addAll: () ->
    @$("#possession_descriptions_table tbody").empty()
    @renderPagination(@options.possessionDescriptions)
    @options.possessionDescriptions.each(@addOne)

  addOne: (possessionDescription) ->
    view = new CertOrbe.Views.PossessionDescriptions.PossessionDescriptionView({model : possessionDescription})
    @$("#possession_descriptions_table tbody").append(view.render().el)

  render: ->
    template = @template(possessionDescriptions: @options.possessionDescriptions.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.possessionDescriptions.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.possessionDescriptions)
