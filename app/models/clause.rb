class Clause < ActiveRecord::Base
  attr_accessible :isfixed, :name, :active

  # has_many :certificate_request_clauses, :dependent => :restrict
  has_many :certificat_requests, :through => :certificate_request_clauses

  has_and_belongs_to_many :transportations

  validates :name, :presence => true, :uniqueness => true

  acts_as_api
  include ApiV1::Clause

  scope :actives, where(:active => true)

end
