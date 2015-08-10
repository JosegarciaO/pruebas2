class CertOrbe.Models.Report extends CertOrbe.Models.BaseModel
  # paramRoot: 'city'
  # urlRoot: 'cities'

  defaults:
    num_constancia: null

class CertOrbe.Collections.ReportsCollection extends CertOrbe.Collections.BaseCollection
  model : CertOrbe.Models.Report
  url   : 'reports/report_certificates'
