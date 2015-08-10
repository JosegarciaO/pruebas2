class PossessionDescriptionsController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
  before_filter :getCatalogos, :only => :index

  belongs_to :possession, :optional => true

  def index
    if params[:possession_id]
      resource = resources_without_pagination(collection)
      respond_to do |format|
        format.html
        format.json { render :json => resource }
      end
    else
      super
    end
  end

  private

  def getCatalogos
  	@possessions = Possession.all
  end

end

