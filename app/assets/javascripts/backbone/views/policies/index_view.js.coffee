CertOrbe.Views.Policies ||= {}

class CertOrbe.Views.Policies.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesPoliciesIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.policies.bind('reset', @addAll)

  events:
    _.extend _.clone(@__super__.events),
      "click #refresh_policies" : "refreshPolicies"

  refreshPolicies: (e) ->
    e.preventDefault()
    @options.policies.fetch()

  addAll: () ->
    @$("#policies_table tbody").empty()
    @renderPagination(@options.policies)
    @options.policies.each(@addOne)

  addOne: (policy) ->
    view = new CertOrbe.Views.Policies.PolicyView({model : policy})
    @$("#policies_table tbody").append(view.render().el)

  render: ->
    template = @template(policies: @options.policies.toJSON(true, true) )
    $(@el).html template
    @addAll()

    return this

  remove: ->
    @options.policies.unbind('reset', @addAll)
    super()

  pagination: (e) ->
    super(e, @options.policies)
