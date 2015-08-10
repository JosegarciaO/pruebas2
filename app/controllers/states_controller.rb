class StatesController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
  before_filter :getCatalogos, :only => :index

  belongs_to :country, :optional => true

  def index
    if params[:country_id]
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
  	@countries = Country.all
  end
end
