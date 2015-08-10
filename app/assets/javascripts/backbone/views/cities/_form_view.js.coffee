CertOrbe.Views.Cities ||= {}

class CertOrbe.Views.Cities.FormView extends CertOrbe.Views.BaseView
	@include Modules.FillSelect

	events:
		_.extend( _.clone(@__super__.events),
			"change #country_id": "changePais"
		)

	changePais: (e) ->
		select = $(e.currentTarget)
		value  = select.val()
		@fill_select(
			url: "countries/#{value}/states"
			target: "#city_state_id"
			select: select
		)
