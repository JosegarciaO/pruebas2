CertOrbe.Views.Reports ||= {}

class CertOrbe.Views.Reports.IndexView extends CertOrbe.Views.BaseView
  template: (data) -> $("#backboneTemplatesReportsIndex").tmpl(data)

  initialize: () ->
    _.bindAll(this, 'showInfo')
    @report_collection = new CertOrbe.Collections.ReportsCollection()
    @report_collection.bind('reset', @showInfo)

  events:
    _.extend _.clone(@__super__.events),
      "change #insurance"      : "changeInsurance"
      "click  #opt-visualizar" : "clickVisualizar"
      "click  #opt-to-pdf"     : "clickExportPDF"
      "click  #opt-to-excel"   : "clickExportExcel"

  render: ->
    template = @template()
    $(@el).html template
    @$(".calendario").datepicker()
    return this

  showInfo: (report_collection) ->
    tipo = $("#type_rpt").val()
    @clearInformation()

    if tipo == '1'
      report_collection.each( (model) ->
        view = new CertOrbe.Views.Reports.ReportDataView({model: model})
        $("#rpt-emitidos tbody").append(view.renderEmitted().el)
      )
      $("#rpt-emitidos").show()
    
    if tipo == '2'
      report_collection.each( (model) ->
        view = new CertOrbe.Views.Reports.ReportDataView({model: model})
        $("#rpt-cancelados tbody").append(view.renderCanceled().el)
      )
      $("#rpt-cancelados").show()

  changeInsurance: (e) ->
    e.preventDefault()
    insurance = $(e.currentTarget).val() || 0
    $("#policy").html('<option value="0">- Todos -</option>')
    @fillPolicies(insurance) if insurance

  fillPolicies: (insurance) ->
    data = CertOrbe.Helpers.jsonData(
      'policies/get_policies_by_insurance'
      {id_insurance: insurance}
    )
    if $.isArray(data)
      for item in data
        switch item.moneda
          when 'M' then moneda = 'MN'
          when 'U' then moneda = 'US'
        $("#policy").append('<option value="' + item.id + '">' + item.folio + ' (' + moneda + ')</option>')

  clickVisualizar: (e) ->
    e.preventDefault()
    $("#type_file").val('')
    params = @getParamsReport()
    if params
      @report_collection.fetch({ data:params })

  clickExportPDF: (e) ->
    e.preventDefault()
    $("#type_file").val('PDF')
    @clearInformation()
    params = @getParamsReport()
    if params
      form = $("#report_form")
      strForm = form.serialize()
      window.location = "reports/report_certificates.pdf?"+ strForm

  clickExportExcel: (e) ->
    e.preventDefault()
    $("#type_file").val('XLS')
    @clearInformation()
    params = @getParamsReport()
    if params
      form = $("#report_form")
      strForm = form.serialize()
      window.location = "reports/report_certificates.xlsx?"+ strForm

  getParamsReport: ->
    params = false
    type_rpt   = $("#type_rpt").val()
    date_start = $("#date_start").val()
    date_end   = $("#date_end").val()
    insurance  = $("#insurance").val() || 0
    policy     = $("#policy").val() || 0
    type_file  = $("#type_file").val() || ''

    if date_start != '' and date_end != ''
      params = {
        type_rpt:   type_rpt,
        date_start: date_start,
        date_end:   date_end,
        insurance:  insurance,
        policy:     policy,
        type_file:  type_file
      }
    else
      alert("Indique el rango de fechas del reporte.")
    return params

  clearInformation: ->
    $("#rpt-emitidos").hide()
    $("#rpt-cancelados").hide()
    $("#rpt-emitidos tbody").empty()
    $("#rpt-cancelados tbody").empty()
