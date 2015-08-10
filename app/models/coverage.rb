class Coverage < ActiveRecord::Base
  attr_accessible :name, :active, :deductible_min

  belongs_to :insurance

  has_many :certificate_request_coverages, :dependent => :restrict
  has_many :certificat_requests, :through => :certificate_request_coverages
  has_many :insurance_coverages, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :deductible_min, :presence => true, :numericality => { :greater_than => 0, :less_than => 100 }

  acts_as_api
  include ApiV1::Coverage

  scope :actives, where(:active => true)

end
