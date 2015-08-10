class CertOrbe.Routers.PoliciesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @policies = new CertOrbe.Collections.PoliciesCollection()
    @policies.reset options.policies

  routes:
    "/new"      : "newPolicy"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newPolicy: ->
    @newPolicyView = new CertOrbe.Views.Policies.NewView(collection: @policies)
    $("#policies").html(@newPolicyView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Policies.IndexView(policies: @policies)
    $("#policies").html(@indexView.render().el)

  show: (id) ->
    policy = @policies.get(id)

    if policy?
      policy.setAllValues()

      @showView = new CertOrbe.Views.Policies.ShowView(model: policy)
      $("#policies").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    policy = @policies.get(id)

    if policy?
      policy.setAllValues()

      @editView = new CertOrbe.Views.Policies.EditView(model: policy)
      $("#policies").html(@editView.render().el)
    else @resourceNotFound()
