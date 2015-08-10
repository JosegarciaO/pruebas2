CertOrbe.Views.Possessions ||= {}

class CertOrbe.Views.Possessions.FormView extends CertOrbe.Views.BaseView

	events:
		_.extend( _.clone(@__super__.events),
			"change #possession_has_max_amount" : "changeHasSumaAsegurada"
		)

	changeHasSumaAsegurada: (e) ->
		if $(e.currentTarget).attr('checked')
			$("#possession_max_amount").removeAttr('disabled')
			$("#possession_max_amount").select()
		else
			@model.set({max_amount: 0})
			$("#possession_max_amount").attr('disabled','disabled')
