class CitiesController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
  before_filter :getCatalogos, :only => :index

  belongs_to :state, :optional => true

  def index
    if params[:state_id]
      resource = resources_without_pagination(collection)
      respond_to do |format|
        format.html
        format.json { render :json => resource }
      end
    else
      instance_variable_set("@#{controller_name}" , resources_with_pagination(collection.search(params[:search] || '')))
      respond_to do |format|
        format.html
        format.json { render :json => instance_variable_get("@#{controller_name}") }
      end
    end
  end

  private

  def getCatalogos
  	# @states = State.all
    @countries = Country.all
  end

end

