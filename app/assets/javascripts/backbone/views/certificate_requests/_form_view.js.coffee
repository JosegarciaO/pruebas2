CertOrbe.Views.CertificateRequests ||= {}

class CertOrbe.Views.CertificateRequests.FormView extends CertOrbe.Views.BaseView
	@include Modules.FillSelect

	events:
		_.extend( _.clone(@__super__.events),
			"change #country_id"      : "changeCountry"
			"change #country_from_id" : "changeCountry"
			"change #country_to_id"   : "changeCountry"
			"change #state_id"        : "changeState"
			"change #state_from_id"   : "changeState"
			"change #state_to_id"     : "changeState"
			"change #certificate_request_policy_id" : "changePoliza"
			"change #certificate_request_use_beneficiario" : "changeUsaBeneficiario"
			"change #certificate_request_base_fee": "calcularImportes"
			"change #certificate_request_importe":  "calcularImportes"
			"change #fecha_salida" : "changeFechaSalida"
			"click #nav-secciones li" : "changeTabNavigation"

			"click #cmdCotizar"   : "statusCotizar"
			"click #cmdAutorizar" : "statusAutorizar"
			"click #cmdEmitir"    : "statusEmitir"
			"click #cmdCancelar"  : "statusCancelar"
		)

	changeCountry: (e) ->
		select = $(e.currentTarget)
		value  = select.val()
		switch e.currentTarget.id
			when "country_id"      then  state_target = "#state_id"
			when "country_from_id" then  state_target = "#state_from_id"
			when "country_to_id"   then  state_target = "#state_to_id"

		@fill_select(
			url: "countries/#{value}/states"
			target: state_target
			select: select
		)

	changeState: (e) ->
		select = $(e.currentTarget)
		value  = select.val()
		switch e.currentTarget.id
			when "state_id"      then  city_target = "#certificate_request_city_id"
			when "state_from_id" then  city_target = "#certificate_request_city_from_id"
			when "state_to_id"   then  city_target = "#certificate_request_city_to_id"

		@fill_select(
			url: "states/#{value}/cities"
			target: city_target
			select: select
		)

	changePoliza: (e) ->
		$("#name_insurance").html("")
		id_poliza = $(e.currentTarget).val()
		if id_poliza
			data = CertOrbe.Helpers.jsonData(
				"policies/getPolizasInfo",
				{ id_poliza:id_poliza }
			)
			if data
				@model.set({expedition_fee: parseFloat(data.expedition).toFixed(2)})
				$("#name_insurance").html(data.insurance)


		else
			@model.set({expedition_fee: 0})
		@calcularImportes()
		#update coverage list
		@initCoberturas(@policies)

	changeUsaBeneficiario: (e) ->
		if $(e.currentTarget).attr('checked')
			$("#certificate_request_beneficiario").removeAttr('disabled')
			$("#certificate_request_beneficiario").select()
		else
			$("#certificate_request_beneficiario").val('')
			$("#certificate_request_beneficiario").attr('disabled','disabled')

	# -- iniciar los detalles de las coberturas
	initCoberturas: (policies) ->
		policy = policies.getById(parseInt(@model.get('policy_id')))
		lista_coberturas = @.model.certificate_request_coverages
		$("#container_coverages").empty()

		return unless policy

		policy.insurance.insurance_coverages.fetch(
			success: (data) ->
				for model in data.models
					coverage_view = new CertOrbe.Views.CertificateRequests.CoveragesView(model: model, lista: lista_coberturas)
					$("#container_coverages").append(coverage_view.render().el)
		)

	# -- iniciar los detalles de las clausulas
	initClauses: ->
		@clauses  = new CertOrbe.Collections.ClausesCollection()
		lista_clausulas  = @.model.certificate_request_clauses
		status = @.model.get('status')
		@clauses.fetch(
			success: (data) ->
				for model in data.models
					# -- mostrar todas las clausulas cuando status = SOLICITADO (para que el supervisor pueda seleccionarlas al cotizar)
					# -- de lo contrario solo mostrar las seleccionadas
					if model.get('active') and (status == 1 or lista_clausulas.getByClauseId(model.get('id')) )
						clause_view = new CertOrbe.Views.CertificateRequests.ClausesView(model: model, lista: lista_clausulas)
						$("#container_clauses").append(clause_view.render().el)
		)

		for transportation_id in @model.get('transportation_ids')
			$('input#certificate_request_transportation_ids_[value=' + transportation_id + ']').attr('checked', true)


	calcularImportes: ->
		# -- calculo de la prima neta
		importe    = parseFloat(@model.get('importe')) || 0
		cuota_base = parseFloat($("#certificate_request_base_fee").val()) || @model.get('base_fee') || 0
		prima_neta = importe * (cuota_base/100)
		$("#txt_prima_neta").val(prima_neta.toFixed(2))

		# -- calculo del IVA
		expedicion  = parseFloat($("#certificate_request_expedition_fee").val()) || 0
		porc_iva    = parseFloat($("#certificate_request_iva_amount").attr('porc_iva')) || 0
		importe_iva = (prima_neta + expedicion) * (porc_iva / 100)
		$("#certificate_request_iva_amount").val(importe_iva.toFixed(2))

		# -- calculo de la prima total
		prima_total = prima_neta + expedicion + importe_iva
		$("#certificate_request_total_prime").val(prima_total.toFixed(2))

	changeFechaSalida: (e)->
		# -- poner fecha de llegada a 30 dias posteriores
		fec = moment($(e.currentTarget).val())
		fec.add("days",30)
		@.model.set({fecha_llegada: fec.format('YYYY-MM-DD')})

	changeTabNavigation: (e) ->
		e.preventDefault()
		$("#nav-secciones li").removeClass('active')
		$(e.currentTarget).addClass('active')
		vista = $(e.currentTarget).find('a').attr('vista')
		# oculta todas las secciones y muestra la seleccionada
		$(".divSecciones").hide()
		$("#" + vista).show()

	statusCotizar: (e) ->
		e.preventDefault()
		if parseFloat(@model.get('base_fee')) == 0
			alert('Ingrese los datos de la cotización.')
		else
			if confirm("¿Desea cotizar la solicitud?")
				$("#edit_certificate_request").trigger('submit')

	statusAutorizar: (e) ->
		e.preventDefault()
		texto = 'autorizar'
		url   = 'certificate_requests/setAuthorizeCertificate'
		@setStatusCertificado(texto, url)

	statusEmitir: (e) ->
		e.preventDefault()
		texto = 'emitir'
		url   = 'certificate_requests/setSealCertificate'
		@setStatusCertificado(texto, url)

	statusCancelar: (e) ->
		e.preventDefault()
		texto = 'cancelar'
		url   = 'certificate_requests/setCancelCertificate'
		@setStatusCertificado(texto, url)

	setStatusCertificado: (texto, url, options = {}) ->
		id_record = @model.get('id')
		if confirm("¿Desea " + texto + " la solicitud?")
			$.ajax(
				url: url
				type: 'POST'
				dataType: 'json'
				data: { id:id_record }
				beforeSend: (xhr) ->
        			token = $('meta[name="csrf-token"]').attr('content')
        			xhr.setRequestHeader('X-CSRF-Token', token) if token
				success: (data, textStatus, jqXHR) ->
					if data
						window.location.hash = '#'
					else
						alert('No se pudo ' + texto + 'el registro. Verifique status.')
			)
