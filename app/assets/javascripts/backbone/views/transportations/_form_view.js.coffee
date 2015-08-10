CertOrbe.Views.Transportations ||= {}

class CertOrbe.Views.Transportations.FormView extends CertOrbe.Views.BaseView

  initClausesList: ->
    transportation = @model
    @clauses  = new CertOrbe.Collections.ClausesCollection()

    @clauses.fetch(
      success: (data) ->
        for model in data.models
          # -- mostrar todas las clausulas cuando status = SOLICITADO (para que el supervisor pueda seleccionarlas al cotizar)
          # -- de lo contrario solo mostrar las seleccionadas
          # if model.get('active') and (status == 1 or lista_clausulas.getByClauseId(model.get('id')) )
          clause_view = new CertOrbe.Views.Transportations.ClauseView(model: model, transportation: transportation)
          $("ul#clauses").append(clause_view.render().el)
    )