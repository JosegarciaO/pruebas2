CertOrbe.Views.Insurances ||= {}

class CertOrbe.Views.Insurances.EditView extends CertOrbe.Views.Insurances.FormView
  template: (data) -> $("#backboneTemplatesInsurancesEdit").tmpl(data)
  itemPossession: (data) -> $("#backboneTemplatesInsurancesInsurancePossessionFieldsForNew").tmpl(data)
  itemAnnex: (data) -> $("#backboneTemplatesInsurancesAnnexFieldsForNew").tmpl(data)
  itemCoverage: (data) -> $("#backboneTemplatesInsurancesInsuranceCoverageFieldsForNew").tmpl(data)

  initialize: ->
    _.bindAll(this,"fieldsForInsurancePossession", "fieldsForAnnex", "fieldsForInsuranceCoverage", "fillInsuranceCoverages")
    @model.prepareToEdit()
    @model.bind("error", @renderErrors)
    @model.insurance_possessions.bind("add",@fieldsForInsurancePossession)
    @model.annexes.bind("add",@fieldsForAnnex)
    @model.insurance_coverages.bind("add",@fieldsForInsuranceCoverage)

  events:
    _.extend( _.clone(@__super__.events),
      "submit #edit_insurance" : "update"
      "click .add-item-possession" : "createInsurancePossession"
      "click .destroy-item-possession" : "destroyInsurancePossession"
      "click .add-item-annex" : "createAnnex"
      "click .destroy-item-annex" : "destroyAnnex"
      "change .check-apply" : "updateDestroyField"
    )

  fillSelects: ->
    @fillOneSelect("#state_id",        "#insurance_city_id",      "states/@/cities", @model.get('state_id'))

  fillOneSelect: (parent, child, url, model_attr) ->
    if $(child).length > 0
      $(child).html('')
      select = $(parent)
      url    = url.replace("@",model_attr)

      @fill_select({
        url:  url
        target: child
        select: select
        model: @model
      }, false)

  fieldsForInsurancePossession: (insurance_possession) ->
    insurance_possession.prepareToEdit()
    domElement = @itemPossession(insurance_possession.toJSON(true))
    insurance_possession.dom_element = domElement
    domElement.find(".destroy-item-possession").data("model",insurance_possession)
    @$("#divBienes tbody").append(
      domElement.backboneLink(@model)
    )

  createInsurancePossession: (e) ->
    e.preventDefault()
    insurance_possession_model = new CertOrbe.Models.InsurancePossession()
    @model.insurance_possessions.add( insurance_possession_model )


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

  fieldsForInsuranceCoverage: (insurance_coverage) ->
    console.log insurance_coverage
    insurance_coverage.prepareToEdit()
    domElement = @itemCoverage(insurance_coverage.toJSON(true))
    console.log domElement
    @$("#divCoberturas tbody").append( domElement )
    # insurance_coverage.dom_element = domElement
    # domElement.data("model",insurance_coverage)
    # @$("#divCoberturas tbody").append(
    #   domElement.backboneLink(@model)
    # )

  render: ->
    @fillInsuranceCoverages()
    $(@el).html( @template( @model.toJSON(true, true) ) )
    this.$("form#edit_insurance").backboneLink(@model)
    @model.insurance_possessions.each(@fieldsForInsurancePossession)
    @model.annexes.each(@fieldsForAnnex)
    @model.insurance_coverages.each(@fieldsForInsuranceCoverage)
    return this

  remove: ->
    @model.insurance_possessions.unbind('add',@fieldsForInsurancePossession)
    @model.annexes.unbind('add',@fieldsForAnnex)
    @model.unbind("error", @renderErrors)
    super()

  updateDestroyField: (e) ->
    if ($(e.currentTarget).is(':checked'))
      $(e.currentTarget).parent().find('input[id *= _destroy]').val("")
    else
      $(e.currentTarget).parent().find('input[id *= _destroy]').val("1")

  fillInsuranceCoverages: ->
    insurance = @model
    coverages = new CertOrbe.Collections.CoveragesCollection()
    coverages.fetch(
      success: (data) ->
        for coverage in data.models
          console.log insurance.insurance_coverages.getByCoverageId(coverage.get('id'))
          if (!insurance.insurance_coverages.getByCoverageId(coverage.get('id')))
            insurance_coverage_model = new CertOrbe.Models.InsuranceCoverage()
            insurance_coverage_model.set({coverage_id: coverage.get('id'), deductible_min: coverage.get('deductible_min'), coverage_name: coverage.get('name')})
            insurance.insurance_coverages.add( insurance_coverage_model )
    )