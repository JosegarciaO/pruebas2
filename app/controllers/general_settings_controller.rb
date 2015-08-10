class GeneralSettingsController < InheritedResources::Base
  include BackboneResponses
  load_and_authorize_resource
  respond_to :json
  before_filter :getTotalRecords, :only => :index

  private

  def getTotalRecords
  	@total_records = GeneralSetting.count
  end

end

