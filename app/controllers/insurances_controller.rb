class InsurancesController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
  before_filter :getCatalogos, :only => :index

  private 

  def getCatalogos
  	@bienes = Possession.actives
  end


end

