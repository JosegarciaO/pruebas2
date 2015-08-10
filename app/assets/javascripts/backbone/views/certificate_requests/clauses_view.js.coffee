CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.ClausesView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesCertificateRequestsClauses").tmpl(data)

  tagName: 'tr'

  initialize: (options) ->
    @cert_req_clauses = options.lista

    # -- Indicar si esta seleccionada la clausula --
    clause_id = @model.get("id")
    rec = @cert_req_clauses.getByClauseId(clause_id)
    if rec
      @model.set({is_included: rec.get('is_included'), transportationFixed: rec.get('is_fixed'), saved: true})
    else
      if @model.get("isfixed")
        rec = new CertOrbe.Models.CertificateRequestClause({clause_id: @model.get('id'), is_included:true, transportationFixed: false})
        @cert_req_clauses.add(rec)

  events:
    _.extend( _.clone(@__super__.events),
      "change .chk_clause" : "changeClause"
    )

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    return this

  changeClause: (e) ->
    checked = e.currentTarget.checked

    @model.set({is_included: checked})
    data = @cert_req_clauses.getByClauseId( @model.get('id') )
    if @model.get("saved")
      data.set({is_included: checked}) if data
    else
      if checked
        rec = new CertOrbe.Models.CertificateRequestClause({clause_id: @model.get('id'), is_included:true})
        @cert_req_clauses.add(rec)
      else
        @cert_req_clauses.remove(data)
