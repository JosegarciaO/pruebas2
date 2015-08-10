class CertOrbe.Routers.ClausesRouter extends CertOrbe.Routers.BaseRouter
  initialize: (options) ->
    @clauses = new CertOrbe.Collections.ClausesCollection()
    @clauses.reset options.clauses

  routes:
    "/new"      : "newClause"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newClause: ->
    @newClauseView = new CertOrbe.Views.Clauses.NewView(collection: @clauses)
    $("#clauses").html(@newClauseView.render().el)

  index: ->
    @indexView = new CertOrbe.Views.Clauses.IndexView(clauses: @clauses)
    $("#clauses").html(@indexView.render().el)

  show: (id) ->
    clause = @clauses.get(id)

    if clause?
      clause.setAllValues()

      @showView = new CertOrbe.Views.Clauses.ShowView(model: clause)
      $("#clauses").html(@showView.render().el)
    else @resourceNotFound()

  edit: (id) ->
    clause = @clauses.get(id)

    if clause?
      clause.setAllValues()

      @editView = new CertOrbe.Views.Clauses.EditView(model: clause)
      $("#clauses").html(@editView.render().el)
    else @resourceNotFound()
