CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.CoveragesView extends CertOrbe.Views.BaseView
	template: (data) -> $("#backboneTemplatesCertificateRequestsCoverages").tmpl(data)

	tagName: 'tr'

	initialize: (options) ->
		@cert_req_coverages = options.lista

		# -- Indicar si esta seleccionada la cobertura --
		coverage_id = @model.get("coverage_id")
		rec = @cert_req_coverages.getByCoverageId(coverage_id)
		if rec
			@model.set({incluir: rec.get('incluir'), deductible: rec.get('deductible'), saved: true})
		else
			# si no existe la cobertura en los detalles, asignar el minimo configurado
			if @model.get('deductible_min')
				@model.set({deductible: @model.get('deductible_min')})
			else
				@model.set({deductible: 0})


	events:
		_.extend( _.clone(@__super__.events),
			"change .chk_coverage" : "changeCoverage"
			"change .txt_ded_coverage" : "changeDeducible"
		)

	render: ->
		$(@el).html( @template( @model.toJSON(true, true) ) )
		return this

	changeCoverage: (e) ->
		checked = e.currentTarget.checked
		@model.set({incluir: checked})
		data = @cert_req_coverages.getByCoverageId( @model.get('coverage_id') )
		if @model.get("saved")
			data.set({incluir: checked}) if data
		else
			if checked
				rec = new CertOrbe.Models.CertificateRequestCoverage({coverage_id: @model.get('coverage_id'), deductible: @model.get('deductible'), incluir:true})
				@cert_req_coverages.add(rec)
			else
				@cert_req_coverages.remove(data)

	changeDeducible: (e) ->
		value = $(e.currentTarget).val()
		data = @cert_req_coverages.getByCoverageId( @model.get('coverage_id') )
		data.set({deductible: value}) if data
