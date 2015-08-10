class PoliciesController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource :except => [:getPoliciesByCurrency, :getPolizasInfo, :get_policies_by_insurance]
  respond_to :json
  before_filter :getCatalogos, :only => :index

  def getPoliciesByCurrency
  	res = Policy::getPoliciesByCurrency(params[:id_moneda],params[:id_poliza])
  	respond_to do |format|
      format.json { render :json => res.to_json }
    end
  end

  def get_policies_by_insurance
    res = Policy.by_insurance(params[:id_insurance] || 0)
    respond_to do |format|
      format.json { render :json => res.to_json }
    end
  end

  def getPolizasInfo
    gastos_expedicion = Policy::getGastosExpedicion(params[:id_poliza])
    insurance_name = Policy.find(params[:id_poliza]).insurance.name
    respond_to do |format|
      format.json { render :json => { :expedition => gastos_expedicion, :insurance => insurance_name } }
    end
  end

  private

  def getCatalogos
  	@insurances = Insurance.all
  	@monedas = ListasGenerales::getMonedas
  end

end

