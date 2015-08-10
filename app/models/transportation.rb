class Transportation < ActiveRecord::Base
  attr_accessible :name, :clause_ids

  acts_as_api
  include ApiV1::Transportation

  has_and_belongs_to_many :clauses
  has_and_belongs_to_many :certificate_requests

  validates_presence_of :name
  validates_uniqueness_of :name

end
