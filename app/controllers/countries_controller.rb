class CountriesController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource :except => [:getCountryDefault]
  respond_to :json
  

  def getCountryDefault
  	res = Country.where(:name => 'mexico')
  	respond_to do |format|
      format.json { render :json => res.first || nil }
    end
  end

end

