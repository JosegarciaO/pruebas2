class PossessionsController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
end

