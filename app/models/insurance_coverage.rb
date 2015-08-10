class InsuranceCoverage < ActiveRecord::Base
  belongs_to :insurance
  belongs_to :coverage
  attr_accessible :deductible_min, :insurance_id, :coverage_id, :apply

  validates :deductible_min, :presence => true, :numericality => { :greater_than => 0, :less_than => 100 }
  validates :insurance_id, :presence => true
  validates :coverage_id, :presence => true, :uniqueness => { :scope => [:insurance_id] }

  attr_accessor :apply

  acts_as_api
  include ApiV1::InsuranceCoverage

end
