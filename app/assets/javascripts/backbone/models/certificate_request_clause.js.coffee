class CertOrbe.Models.CertificateRequestClause extends CertOrbe.Models.BaseModel
  paramRoot: 'certificate_request_clause'
  urlRoot: 'certificate_request_clauses'

  defaults:
    certificate_request: null
    clause: null
    is_included: null
    is_fixed: null
    transportationFixed: null

  removeWhenSaving: ['transportationFixed']

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  belongsTo:
    certificate_request:
      model: "CertificateRequest"

  belongsTo:
    clause:
      model: "Clause"

  @paramRoot : 'certificate_request_clause'
  @urlRoot   : 'certificate_request_clauses'

class CertOrbe.Collections.CertificateRequestClausesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.CertificateRequestClause
  url   : '/certificate_request_clauses'

  getByClauseId: (id) ->
    data = @.filter((rec) ->
      return rec.get('clause_id') == id
    )
    if data.length > 0
      return data[0]
    else
      return null
