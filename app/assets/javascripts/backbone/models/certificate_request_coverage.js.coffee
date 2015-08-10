class CertOrbe.Models.CertificateRequestCoverage extends CertOrbe.Models.BaseModel
  paramRoot: 'certificate_request_coverage'
  urlRoot: 'certificate_request_coverages'

  defaults:
    certificate_request_id: null
    coverage_id: null
    incluir: false
    deductible: 0.00

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
    coverage:
      model: "Coverage"

  @paramRoot : 'certificate_request_coverage'
  @urlRoot   : 'certificate_request_coverages'

class CertOrbe.Collections.CertificateRequestCoveragesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.CertificateRequestCoverage
  url   : '/certificate_request_coverages'

  getByCoverageId: (id) ->
    data = @.filter((rec) ->
      return rec.get('coverage_id') == id
    )
    if data.length > 0
      return data[0]
    else
      return null
