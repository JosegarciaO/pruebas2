class PossessionDescription < ActiveRecord::Base
  attr_accessible :name, :possession_id
  
  belongs_to :possession
  has_many :certificate_requests, :dependent => :restrict

  default_scope order(:name)

  validates :name, :presence => true, :uniqueness => { :scope => [:possession_id] }
  validates :possession_id, :presence => true

  acts_as_api
  include ApiV1::PossessionDescription

end
