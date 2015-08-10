class AnnexesController < InheritedResources::Base
  include BackboneResponses

  respond_to :json
end

