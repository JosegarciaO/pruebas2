CertOrbe.Views.Insurances ||= {}

class CertOrbe.Views.Insurances.FormView extends CertOrbe.Views.BaseView
  @include Modules.FillSelect

  events:
    _.extend( _.clone(@__super__.events),
      "click #nav-secciones li"   : "changeTabNavigation"
      "change #state_id"          : "changeState"
    )

  changeTabNavigation: (e) ->
    $("#nav-secciones li").removeClass('active')
    $(e.currentTarget).addClass('active')
    vista = $(e.currentTarget).find('a').attr('vista')
    # oculta todas las secciones y muestra la seleccionada
    $(".divSecciones").hide()
    $("#" + vista).show()

  changeState: (e) ->
    select = $(e.currentTarget)
    value  = select.val()

    @fill_select(
      url: "states/#{value}/cities"
      target: "#insurance_city_id"
      select: select
    )