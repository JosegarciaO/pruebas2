class Packaging < ActiveRecord::Base
  attr_accessible :name

  has_many :certificate_requests, :dependent => :restrict

  validates :name, :presence => true, :uniqueness => true

  acts_as_api
  include ApiV1::Packaging

end
