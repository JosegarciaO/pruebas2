CertOrbe.Views.Packagings ||= {}

class CertOrbe.Views.Packagings.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPackagingsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.packagings.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_packagings" : "refreshPackagings"

  refreshPackagings: (e) ->
    e.preventDefault()
    @options.packagings.fetch()

  addAll: () ->
    @$("#packagings_table tbody").empty()
    @renderPagination(@options.packagings)
    @options.packagings.each(@addOne)

  addOne: (packaging) ->
    view = new CertOrbe.Views.Packagings.PackagingView({model : packaging})
    @$("#packagings_table tbody").append(view.render().el)

  render: ->
    template = @template(packagings: @options.packagings.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.packagings.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.packagings)
