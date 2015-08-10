CertOrbe.Views.Reports ||= {}

class CertOrbe.Views.Reports.ReportDataView extends CertOrbe.Views.BaseView
  tplEmitidos:   (data) -> $("#backboneTemplatesReportsReportDataEmitted").tmpl(data)
  tplCancelados: (data) -> $("#backboneTemplatesReportsReportDataCanceled").tmpl(data)

  tagName: 'tr'

  renderEmitted: ->
    $(@el).html( @tplEmitidos( @model.toJSON(true, true) ) )
    return this

  renderCanceled: ->
    $(@el).html( @tplCancelados( @model.toJSON(true, true) ) )
    return this
