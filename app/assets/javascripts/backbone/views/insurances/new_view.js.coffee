CertOrbe.Views.Insurances ||= {}

class CertOrbe.Views.Insurances.NewView extends CertOrbe.Views.Insurances.FormView
  template: (data) -> $("#backboneTemplatesInsurancesNew").tmpl(data)
  itemPossession: (data) -> $("#backboneTemplatesInsurancesInsurancePossessionFieldsForNew").tmpl(data) #
  itemAnnex: (data) -> $("#backboneTemplatesInsurancesAnnexFieldsForEdit").tmpl(data)

  initialize: (options) ->
    _.bindAll(this,"fieldsForInsurancePossession")
    super(options)
    @model = new @collection.model()
    @model.bind("error", @renderErrors)
    @model.insurance_possessions.bind("add",@fieldsForInsurancePossession)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #new_insurance": "save"
      "click .add-item-possession" : "createInsurancePossession"
      "click .destroy-item-possession" : "destroyInsurancePossession"
    )

  fieldsForInsurancePossession: (insurance_possession) ->
    domElement = @itemPossession(insurance_possession.toJSON(true))
    insurance_possession.dom_element = domElement
    domElement.find(".destroy-item-possession").data("model",insurance_possession)
    $("#divBienes tbody").append(
      domElement.backboneLink(@model)
    )

  createInsurancePossession: (e) ->
    e.preventDefault()
    insurance_possession = new CertOrbe.Models.InsurancePossession()
    @model.insurance_possessions.add( insurance_possession )


  destroyInsurancePossession: (e) ->
    e.preventDefault()
    e.stopPropagation()

    msg = $(e.currentTarget).attr("data-confirm")
    if msg? and !confirm(msg) then return false
    model = $(e.currentTarget).data("model")

    domElement = model.dom_element
    model.destroy()
    domElement.remove()
    return false

  fieldsForAnnex: (annex) ->
    annex.prepareToEdit()
    domElement = @itemAnnex(annex.toJSON(true))
    annex.dom_element = domElement
    domElement.find(".destroy-item-annex").data("model", annex)
    @$("#divAnnexes").append(
      domElement.backboneLink(@model)
    )

  createAnnex: (e) ->
    e.preventDefault()
    annex_model = new CertOrbe.Models.Annex()
    @model.annexes.add( annex_model )

  destroyAnnex: (e) ->
    e.preventDefault()
    e.stopPropagation()

    msg = $(e.currentTarget).attr("data-confirm")
    if msg? and !confirm(msg) then return false
    model = $(e.currentTarget).data("model")

    domElement = model.dom_element
    model.destroy()
    domElement.remove()
    return false

  render: ->
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#new_insurance").backboneLink(@model)
    return this

  remove: ->
    @model.insurance_possessions.unbind('add',@fieldsForInsurancePossession)
    @model.unbind("error", @renderErrors)
    super()
