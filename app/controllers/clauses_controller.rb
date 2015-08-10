class ClausesController < InheritedResources::Base
  include BackboneResponses

  respond_to :json
end

