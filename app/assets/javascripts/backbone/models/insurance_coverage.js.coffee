class CertOrbe.Models.InsuranceCoverage extends CertOrbe.Models.BaseModel
  paramRoot: 'insurance_coverage'
  urlRoot: 'insurance_coverages'

  defaults:
    insurance: null
    coverage: null
    deductible_min: null
    coverage_id: null
    coverage_name: null
    apply: null

  validate: (attrs) ->
    return @validates(attrs, {
      # example
      # <field_name>:
      #   presence: true
    })

  belongsTo:
    insurance:
      model: "Insurance"

  @paramRoot : 'insurance_coverage'
  @urlRoot   : 'insurance_coverages'

class CertOrbe.Collections.InsuranceCoveragesCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.InsuranceCoverage
  url   : '/insurance_coverages'

  getByCoverageId: (id) ->
    data = @.filter((rec) ->
      return rec.get('coverage_id') == id
    )
    if data.length > 0
      return data[0]
    else
      return null