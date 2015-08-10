class InsuranceCoveragesController < InheritedResources::Base
  include BackboneResponses

  belongs_to :insurance

  respond_to :json
end

