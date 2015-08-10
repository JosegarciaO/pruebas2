class Annex < ActiveRecord::Base

  belongs_to :insurance

  has_attached_file :image,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"

  attr_accessible :image

  acts_as_api
  include ApiV1::Annex

end
